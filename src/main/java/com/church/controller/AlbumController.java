//작성자 : 김도영
//최초 작성일 : 23.04.04
package com.church.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Stream;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.church.domain.AlbumPaging;
import com.church.domain.Albums;
import com.church.domain.AttachFile;
import com.church.service.AlbumsService;
import com.church.service.AttachFileService;
import com.church.service.ChatGPTService;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/album")
public class AlbumController {
	
	@Autowired
	private AlbumsService albumsService;
	
	@Autowired
	private AttachFileService attachFileService;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@ResponseBody
	@PostMapping(value="/answer", produces="text/plain;charset=UTF-8")
	public String answer(@RequestParam String prompt, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String answer = ChatGPTService.chatGPT(prompt);
		System.out.println(answer);
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
            @RequestParam("image") String[] images, HttpServletRequest request) {
		
		if(principal != null) {
		String userId = principal.getName();
		albums.put("awriter", userId);
		}
		
		try {
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
			
			cleanAttach(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/album/list";
	}
	
	@GetMapping("/delete")
	public String delete() {
		return "/album/delete";
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public void deleteAlbums(@RequestParam String ano, HttpServletRequest request) {
		try {
			albumsService.delete(ano);
			
			cleanAttach(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("ano") String ano, Model model,
			HttpServletRequest request,
			HttpServletResponse response, Principal principal) {
        if (ano == null) {
            HttpSession session = request.getSession();
            String errorMessage;

            errorMessage = "존재하지 않는 게시물 입니다.<br>다시 이용해주세요.";

            session.setAttribute("errorMessage", errorMessage);

            return "redirect:/album/list";
        }

		
		try {
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
			
			String username = null;
			
			if(principal != null) {
			String userId = principal.getName();
			username = userId;
			}
			
			
			//조회수 증가
			viewCountValidation(albumsById, ano, username, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/album/detail";
	}
	
		private void viewCountValidation(Albums albums, 
				String ano,
				String username,
				HttpServletRequest request, 
				HttpServletResponse response) {
				try {
				Cookie[] cookies = request.getCookies();
				
				Cookie cookie = null;
				boolean isCookie = false;
				
				// request에 쿠키들이 있을 때
				for (int i = 0; cookies != null && i < cookies.length; i++) {
				// 사용자명_board 쿠키가 있을 때
				if (cookies[i].getName().equals(username + "_album")) {//다른 게시판은 "_album" 변경 
				// cookie 변수에 저장
				cookie = cookies[i];
				// 만약 cookie 값에 현재 게시글 번호가 없을 때
				if (!cookie.getValue().contains("[" + albums.getAno() + "]")) {
				// 해당 게시글 조회수를 증가시키고, 쿠키 값에 해당 게시글 번호를 추가
				albumsService.updateView(ano);
				cookie.setValue(cookie.getValue() + "[" + albums.getAno() + "]");
				}
				isCookie = true;
				break;
				}
				}
				
				// 만약 사용자명_board라는 쿠키가 없으면 처음 접속한 것이므로 새로 생성
				if (!isCookie) { 
					albumsService.updateView(ano);
				cookie = new Cookie(username + "_album", "[" + albums.getAno() + "]"); // oldCookie에 새 쿠키 생성
				}
				
				// 쿠키 유지시간을 오늘 하루 자정까지로 설정
				long todayEndSecond = LocalDate.now().atTime(LocalTime.MAX).toEpochSecond(ZoneOffset.UTC);
				long currentSecond = LocalDateTime.now().toEpochSecond(ZoneOffset.UTC);
				cookie.setPath("/"); // 모든 경로에서 접근 가능
				cookie.setMaxAge((int) (todayEndSecond - currentSecond + 32400));//크롬 UTC 기준 +9시간(32400초) 필요 
				response.addCookie(cookie);
				} catch(Exception e) {
				e.printStackTrace();
				}
	}
	
	@GetMapping("/list")
	public String list(Model model, @RequestParam(value = "num",required = false, defaultValue = "1") int num, 
			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword) throws Exception {
		
		
		try {
			AlbumPaging page = new AlbumPaging();
			
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/album/list";
	 
	}	
	
	@GetMapping("/modify")
	public String modify(@RequestParam String ano, Model model, HttpServletRequest request) {
        if (ano == null) {
            HttpSession session = request.getSession();
            String errorMessage;

            errorMessage = "존재하지 않는 게시물 입니다.<br>다시 이용해주세요.";

            session.setAttribute("errorMessage", errorMessage);

            return "redirect:/album/list";
        }
		
		try {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/album/modify";
	}
	
	@PostMapping("/modify")
	public String editAlbum(@RequestParam Map<String, Object> albums, Principal principal, Model model,
			@RequestParam("fileName") String[] fileNames,
            @RequestParam("upFolder") String[] upFolders,
            @RequestParam("uuid") String[] uuids,
            @RequestParam("image") String[] images, HttpServletRequest request) {
		
			try {
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

  				cleanAttach(request);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		return "redirect:/album/list";
	}
	
	//썸네일 이미지 전송
	@GetMapping("/display")
	public ResponseEntity<byte[]> display(String fileName, HttpServletRequest request){

		
		
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		File file = new File(path + "/images/" + fileName);
		
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
	public ResponseEntity<String> deleteFile(String fileName, String type, HttpServletRequest request){
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		
		try {
			File file = new File(path + "/images/" + URLDecoder.decode(fileName, "UTF-8"));
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
	public ResponseEntity<List<AttachFile>> uploadAjax(MultipartFile[] uploadFile, HttpServletRequest request) {
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		
		String upPath = path + "/images";
		
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
					
//					FileOutputStream fos = new FileOutputStream(new File(upFolder, "s_" + upFileName));
				
					// 원본 이미지를 읽어와서 BufferedImage 객체로 변환
					BufferedImage originalImage = ImageIO.read(multi.getInputStream());

					// 원본 이미지의 크기를 확인하고, 지정한 크기보다 큰 경우에는 축소
					int originalWidth = originalImage.getWidth();
					int originalHeight = originalImage.getHeight();
					if (originalWidth > 100 || originalHeight > 100) {
					    float scale = Math.min(100f / originalWidth, 100f / originalHeight);
					    int newWidth = Math.round(originalWidth * scale);
					    int newHeight = Math.round(originalHeight * scale);

					    BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, originalImage.getType());
					    Graphics2D g = resizedImage.createGraphics();
					    g.drawImage(originalImage, 0, 0, newWidth, newHeight, null);
					    g.dispose();

					    originalImage = resizedImage;
					}

//
//					// 썸네일 이미지 생성
//					File thumbnailFile = new File(upFolder, "s_" + upFileName);
//					Thumbnailator.createThumbnail(originalImage, thumbnailFile, 100, 100);
					
					
					
					// 썸네일 이미지 생성
					BufferedImage thumbnail = Thumbnailator.createThumbnail(originalImage, 100, 100);
					File thumbnailFile = new File(upFolder, "s_" + upFileName);
					ImageIO.write(thumbnail, "png", thumbnailFile);

					
					
					
//					// 썸네일 이미지 생성
//					Thumbnailator.createThumbnail(originalImage, fos, 100, 100);
//					fos.close();
					
//					   // 썸네일 이미지 압축
//				    Thumbnails.of(new File(upFolder, "s_" + upFileName))
//				              .size(100, 100)
//				              .outputQuality(1.0)
//				              .toFile(thumbnailFile);
				    
				    
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
	
	public void deleteAttach(List<AttachFile> attachList, HttpServletRequest request){ //첨부파일 삭제
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		
		if (attachList == null || attachList.size() < 1) {
			return;
			
		}
		
		
		attachList.forEach(abvo -> {
			try {
			Path file = Paths.get(path + "/images/" + abvo.getUpFolder() + "/" + abvo.getUuid() + "_" + abvo.getFileName());
			
				Files.deleteIfExists(file); //파일이 존재하면 삭제
//				Files.exists(path)
			
			if (Files.probeContentType(file).startsWith("image")) { //이미지 파일의 경우
				Path thumbnail = Paths.get(path + "/images/" + abvo.getUpFolder() + "/s_" + abvo.getUuid() + "_" + abvo.getFileName());
				Files.delete(thumbnail); //썸네일 삭제
			}
			
			} catch (IOException e) {
				e.printStackTrace();
			} 
			
		});
		
	}
	
	public void cleanAttach(HttpServletRequest request){ //DB에 있는 데이터와 폴더에 있는 첨부파일이 일치하는 것들 이외에 삭제
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		
		List<AttachFile> attachList = attachFileService.allFiles();
		
		if (attachList == null || attachList.size() < 1) {
			return;
			
		}

	    try (Stream<Path> files = Files.walk(Paths.get(path + "/images/"))) {
	        files.filter(file -> {
	                // DB에 존재하는 파일 리스트에 포함되어 있지 않으면 true 반환
	                return attachList.stream()
	                                 .noneMatch(dbFile -> Paths.get(path + "/images/" + dbFile.getUpFolder() + "/" + dbFile.getUuid() + "_" + dbFile.getFileName()).equals(file)
	                                           || Paths.get(path + "/images/" + dbFile.getUpFolder() + "/s_" + dbFile.getUuid() + "_" + dbFile.getFileName()).equals(file));
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
