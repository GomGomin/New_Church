package com.church.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Stream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.church.domain.Albums;
import com.church.domain.AttachFile;
import com.church.domain.Paging;
import com.church.domain.Users;
import com.church.service.AlbumsService;
import com.church.service.AttachFileService;
import com.church.service.ChatGPTService;
import com.church.service.UsersService;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/album")
public class AlbumController {
	
	@Autowired
	private AlbumsService albumsService;
	
	@Autowired
	private UsersService usersService;
	
	@Autowired
	private AttachFileService attachFileService;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@ResponseBody
	@PostMapping(value="/answer", produces="text/plain;charset=UTF-8")
	public String answer(@RequestParam String prompt, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String answer = ChatGPTService.chatGPT(prompt);
		return answer;
	}
	
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String header() {
		return "/album/header";
	}
	
	@GetMapping("/add")
	public String add(@ModelAttribute("albums") Albums albums) {
		return "/album/add";
	}
	
	@PostMapping("/add")
	public String addAlbums(@RequestParam Map<String, Object> albums, Principal principal, Model model,
			@RequestParam("fileName") String[] fileNames,
            @RequestParam("upFolder") String[] upFolders,
            @RequestParam("uuid") String[] uuids,
            @RequestParam("image") String[] images) {
		
		if(principal != null) {
		String userId = principal.getName();
		Users user = usersService.detailUser(userId);
		albums.put("awriter", user.getName());
		}
		
		albumsService.insert(albums);
		
		Albums recentAlbum = albumsService.recent();
		
		  
		  if (fileNames != null) {
			  for (int i = 0; i < fileNames.length; i++) {
				  Map<String, Object> album = new HashMap<String, Object>();
				  album.put("ano", recentAlbum.getAno()); 
				  album.put("fileName", fileNames[i]);
				  album.put("upFolder", upFolders[i]);
				  album.put("uuid", uuids[i]);
				  album.put("image", images[i]);
				  attachFileService.insertAttach(album);
			}
		  }
		
		cleanAttach();
		
		return "redirect:/album/list";
	}
	
	@GetMapping("/delete")
	public String delete() {
		return "/album/delete";
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public void deleteAlbums(@RequestParam String ano) {
		albumsService.delete(ano);
		
		cleanAttach();
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("ano") String ano, Model model) {
		
		//조회수 증가
		albumsService.updateView(ano);
		
		//주 게시물
		Albums albumsById = albumsService.detail(ano);
		model.addAttribute("albums", albumsById);

		//첨부파일
		List<AttachFile> attachList = attachFileService.selectAttachAll(ano);
		
		List<String> attachPaths = new ArrayList<String>();
		
		for (AttachFile attach : attachList) {
			
			String filePath = attach.getUpFolder().replaceAll("\\\\", "/") + "/" + attach.getUuid() + "_" + attach.getFileName();
			

			attachPaths.add(filePath);

		}
		
		model.addAttribute("attachPaths", attachPaths);
		
		return "/album/detail";
	}
	
	@GetMapping("/list")
	public String list(Model model, @RequestParam(value = "num",required = false, defaultValue = "1") int num, 
			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword) throws Exception {
		Paging page = new Paging();
		
		page.setNum(num);
		page.setCount(albumsService.searchCount(searchType, keyword));
		page.setSearchType(searchType);
		page.setKeyword(keyword);

		List<Albums> albumList = null; 
		albumList = albumsService.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
	 
		model.addAttribute("albumList", albumList);
		model.addAttribute("page", page);
		model.addAttribute("select", num);
		
		
		Map<Integer, Object> attachFileList = new HashMap<Integer, Object>();
		
		for (Albums albums : albumList) {
			AttachFile attachFile = attachFileService.oneAttach(albums.getAno());
			
			attachFile.getUpFolder().replaceAll("\\\\", "/");
			
			String filePath = attachFile.getUpFolder().replaceAll("\\\\", "/") + "/" + attachFile.getUuid() + "_" + attachFile.getFileName();

			attachFileList.put(albums.getAno(), filePath);

		}
		
		model.addAttribute("attachFileList", attachFileList);
		
		return "/album/list";
	 
	}	
	
	@GetMapping("/modify")
	public String modify(@RequestParam String ano, Model model) {
		
		
		//주 게시물
		Albums albumsById = albumsService.detail(ano);
		model.addAttribute("albums", albumsById);

		//첨부파일
		List<AttachFile> attachList = attachFileService.selectAttachAll(ano);
		
		List<String> attachPaths = new ArrayList<String>();
		
		for (AttachFile attach : attachList) {
			
			String filePath = attach.getUpFolder().replaceAll("\\\\", "/") + "/" + attach.getUuid() + "_" + attach.getFileName();
			

			attachPaths.add(filePath);

		}
		
		model.addAttribute("attachPaths", attachPaths);
		
		model.addAttribute("attachList", attachList);
		
		return "/album/modify";
	}
	
	@PostMapping("/modify")
	public String editAlbum(@RequestParam Map<String, Object> albums, Principal principal, Model model,
			@RequestParam("fileName") String[] fileNames,
            @RequestParam("upFolder") String[] upFolders,
            @RequestParam("uuid") String[] uuids,
            @RequestParam("image") String[] images) {
		
			albumsService.update(albums);
		
			attachFileService.deleteAttach((String) albums.get("ano"));
		  
		  if (fileNames != null) {
			  for (int i = 0; i < fileNames.length; i++) {
				  Map<String, Object> album = new HashMap<String, Object>();
				  album.put("ano", albums.get("ano")); 
				  album.put("fileName", fileNames[i]);
				  album.put("upFolder", upFolders[i]);
				  album.put("uuid", uuids[i]);
				  album.put("image", images[i]);

				  attachFileService.insertAttach(album);
			}
		  }
		
		cleanAttach();
		
		return "redirect:/album/list";
	}
	
	//썸네일 이미지 전송
	@GetMapping("/display")
	public ResponseEntity<byte[]> display(String fileName){
		File file = new File(uploadPath + "\\images\\" + fileName);
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		
		
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName, String type){
		
		try {
			File file = new File(uploadPath + "\\images\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();	//파일 삭제
			
			if(type.equals("image")) {//이미지 파일이면 원본 파일 삭제
				String originFile = file.getAbsolutePath().replace("s_", "");	//원본 파일명
				file = new File(originFile);
				file.delete(); //원본 이미지 삭제
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<>("deleted", HttpStatus.OK);
		
	}
	
	@PostMapping("/upload/ajaxAction")
	public ResponseEntity<List<AttachFile>> uploadAjax(MultipartFile[] uploadFile) {
		String upPath = uploadPath + "\\images";
		
		List<AttachFile> attachList = new ArrayList<>();
		
		

		
		// 연/월/일 폴더 생성
		File upFolder = new File(upPath, getFolder());
		
		//업로드 경로에 해당 폴더가 없는 경우에는 생성
		if( !upFolder.exists() ) {
			upFolder.mkdirs();
			
		}
		
		
		for(MultipartFile multi : uploadFile) {
		
			
			UUID uuid = UUID.randomUUID();
			
			String upFileName = uuid + "_" + multi.getOriginalFilename();
			
//			File saveFile = new File(upPath, multi.getOriginalFilename());
			File saveFile = new File(upFolder, upFileName);
			
		
			AttachFile adto = new AttachFile();
			
			adto.setUpFolder(getFolder());
//			adto.setFileName(upFileName);
			adto.setFileName(multi.getOriginalFilename());
			adto.setUuid(uuid.toString());
			
			try {
				multi.transferTo(saveFile); //파일 업로드 처리
				
				if(checkImgType(saveFile)) { //이미지 파일의 경우 
					
					adto.setImage(true);
					
					FileOutputStream fos = new FileOutputStream(new File(upFolder, "s_" + upFileName));
				
						
						
						
					
				Thumbnailator.createThumbnail( //섬네일 이미지 생성
						multi.getInputStream(), fos, 100, 100);
					fos.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		attachList.add(adto);
		}//END for
		
		return new ResponseEntity<>(attachList, HttpStatus.OK);
		
		
		
	}//END uploadAjax
	
	//현재 시점의 '연/월/일' 폴더 경로 문자열 생성하여 반환
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(new Date());
		
		return str.replace("-", File.separator);
	}
	
	//이미지 파일 여부 확인
	public boolean checkImgType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
		
	}
	
	@GetMapping("/attachList") // 첨부파일 목록
	public ResponseEntity<List<AttachFile>> attachList(String ano) {
		
		//첨부파일 목록과 200번 코드 반환
		return new ResponseEntity<>(attachFileService.selectAttachAll(ano), HttpStatus.OK);
	
	}
	
	public void deleteAttach(List<AttachFile> attachList){ //첨부파일 삭제
		
		
		if (attachList == null || attachList.size() < 1) {
			return;
			
		}
		
		
		attachList.forEach(abvo -> {
			try {
			Path file = Paths.get(uploadPath + "\\images\\" + abvo.getUpFolder() + "\\" + abvo.getUuid() + "_" + abvo.getFileName());
			
				Files.deleteIfExists(file); //파일이 존재하면 삭제
//				Files.exists(path)
			
			if (Files.probeContentType(file).startsWith("image")) { //이미지 파일의 경우
				Path thumbnail = Paths.get(uploadPath + "\\images\\" + abvo.getUpFolder() + "\\s_" + abvo.getUuid() + "_" + abvo.getFileName());
				Files.delete(thumbnail); //썸네일 삭제
			}
			
			} catch (IOException e) {
				e.printStackTrace();
			} 
			
		});
		
	}
	
	public void cleanAttach(){ //DB에 있는 데이터와 폴더에 있는 첨부파일이 일치하는 것들 이외에 삭제
		
		List<AttachFile> attachList = attachFileService.allFiles();
		
		if (attachList == null || attachList.size() < 1) {
			return;
			
		}

	    try (Stream<Path> files = Files.walk(Paths.get(uploadPath + "\\images\\"))) {
	        files.filter(file -> {
	                // DB에 존재하는 파일 리스트에 포함되어 있지 않으면 true 반환
	                return attachList.stream()
	                                 .noneMatch(dbFile -> Paths.get(uploadPath + "\\images\\" + dbFile.getUpFolder() + "\\" + dbFile.getUuid() + "_" + dbFile.getFileName()).equals(file)
	                                           || Paths.get(uploadPath + "\\images\\" + dbFile.getUpFolder() + "\\s_" + dbFile.getUuid() + "_" + dbFile.getFileName()).equals(file));
	            })
	            .forEach(file -> {
	                try {
	                    Files.delete(file);
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            });
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
		
		
		
	}


	

}
