<<<<<<< HEAD
////작성자 : 김도영
////최초 작성일 : 23.04.04
//package com.church.controller;
=======
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

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.church.domain.AlbumPaging;
import com.church.domain.Weekly;
import com.church.domain.WeeklyAttach;
import com.church.service.WeeklyAttachService;
import com.church.service.WeeklyService;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/weekly")
public class WeeklyController {
	
	
	@Autowired
	private WeeklyService weeklyService;
	
	@Autowired
	private WeeklyAttachService weeklyAttachService;
	
	@GetMapping("/add")
	public String add(@ModelAttribute("weekly") Weekly weekly) {
		return "/weekly/add";
	}
	
	@PostMapping("/add")
	public String addWeekly(@RequestParam Map<String, Object> weekly, Principal principal, Model model,
			@RequestParam("fileName") String[] fileNames,
            @RequestParam("upFolder") String[] upFolders,
            @RequestParam("uuid") String[] uuids,
            @RequestParam("image") String[] images, HttpServletRequest request) {
		
		try {
			
			if(principal != null) {
				String userId = principal.getName();
				weekly.put("wwriter", userId);
				}
				
				weeklyService.insert(weekly);
				
				Weekly recentWeekly = weeklyService.recent();
				
				  
				  if (fileNames != null) {
					  for (int i = 0; i < fileNames.length; i++) {
						  Map<String, Object> weeklys = new HashMap<String, Object>();
						  weeklys.put("wno", recentWeekly.getWno()); 
						  weeklys.put("fileName", fileNames[i]);
						  weeklys.put("upFolder", upFolders[i]);
						  weeklys.put("uuid", uuids[i]);
						  weeklys.put("image", images[i]);
						  weeklyAttachService.insertAttach(weeklys);
					}
				  }
				
				cleanAttach(request);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		
		return "redirect:/weekly/list";
	}
	
	@GetMapping("/delete")
	public String delete() {
		return "/weekly/delete";
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public void deleteWeekly(@RequestParam String wno, HttpServletRequest request) {
		try {
			weeklyService.delete(wno);
			
			cleanAttach(request);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		

	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam("wno") String wno, Model model,
			HttpServletRequest request,
			HttpServletResponse response, Principal principal) {
		

		
		try {
			//주 게시물
			Weekly weeklyById = weeklyService.detail(wno);
			model.addAttribute("weekly", weeklyById);

			//첨부파일
			List<WeeklyAttach> attachList = weeklyAttachService.selectAttachAll(wno);
			
			List<String> attachPaths = new ArrayList<String>();
			
			for (WeeklyAttach attach : attachList) {
				
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
			viewCountValidation(weeklyById, wno, username, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/weekly/detail";
	}
	
		private void viewCountValidation(Weekly weekly, 
				String wno,
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
				if (cookies[i].getName().equals(username + "_weekly")) {//다른 게시판은 "_weekly" 변경 
				// cookie 변수에 저장
				cookie = cookies[i];
				// 만약 cookie 값에 현재 게시글 번호가 없을 때
				if (!cookie.getValue().contains("[" + weekly.getWno() + "]")) {
				// 해당 게시글 조회수를 증가시키고, 쿠키 값에 해당 게시글 번호를 추가
				weeklyService.updateView(wno);
				cookie.setValue(cookie.getValue() + "[" + weekly.getWno() + "]");
				}
				isCookie = true;
				break;
				}
				}
				
				// 만약 사용자명_board라는 쿠키가 없으면 처음 접속한 것이므로 새로 생성
				if (!isCookie) { 
					weeklyService.updateView(wno);
				cookie = new Cookie(username + "_weekly", "[" + weekly.getWno() + "]"); // oldCookie에 새 쿠키 생성
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
			page.setCount(weeklyService.searchCount(searchType, keyword));
			page.setSearchType(searchType);
			page.setKeyword(keyword);

			List<Weekly> weeklyList = null; 
			weeklyList = weeklyService.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
 
			model.addAttribute("weeklyList", weeklyList);
			model.addAttribute("page", page);
			model.addAttribute("select", num);
			
			
			Map<Integer, Object> WeeklyAttachList = new HashMap<Integer, Object>();
			
			for (Weekly weekly : weeklyList) {
				WeeklyAttach WeeklyAttach = weeklyAttachService.oneAttach(weekly.getWno());
				
				WeeklyAttach.getUpFolder().replaceAll("\\\\", "/");
				
				String filePath = WeeklyAttach.getUpFolder().replaceAll("\\\\", "/") + "/" + WeeklyAttach.getUuid() + "_" + WeeklyAttach.getFileName();

				WeeklyAttachList.put(weekly.getWno(), filePath);

			}
			
			model.addAttribute("WeeklyAttachList", WeeklyAttachList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/weekly/list";
	 
	}	
	
	@GetMapping("/modify")
	public String modify(@RequestParam String wno, Model model) {
		
		try {
			//주 게시물
			Weekly weeklyById = weeklyService.detail(wno);
			model.addAttribute("weekly", weeklyById);

			//첨부파일
			List<WeeklyAttach> attachList = weeklyAttachService.selectAttachAll(wno);
			
			List<String> attachPaths = new ArrayList<String>();
			
			for (WeeklyAttach attach : attachList) {
				
				String filePath = attach.getUpFolder().replaceAll("\\\\", "/") + "/" + attach.getUuid() + "_" + attach.getFileName();
				

				attachPaths.add(filePath);

			}
			
			model.addAttribute("attachPaths", attachPaths);
			
			model.addAttribute("attachList", attachList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/weekly/modify";
	}
	
	@PostMapping("/modify")
	public String editAlbum(@RequestParam Map<String, Object> weekly, Principal principal, Model model,
			@RequestParam("fileName") String[] fileNames,
            @RequestParam("upFolder") String[] upFolders,
            @RequestParam("uuid") String[] uuids,
            @RequestParam("image") String[] images, HttpServletRequest request) {
		
			try {
				weeklyService.update(weekly);

				weeklyAttachService.deleteAttach((String) weekly.get("wno"));
  
				  if (fileNames != null) {
								  for (int i = 0; i < fileNames.length; i++) {
									  Map<String, Object> album = new HashMap<String, Object>();
									  album.put("wno", weekly.get("wno")); 
									  album.put("fileName", fileNames[i]);
									  album.put("upFolder", upFolders[i]);
									  album.put("uuid", uuids[i]);
									  album.put("image", images[i]);
				
									  weeklyAttachService.insertAttach(album);
								}
				  }

			  		cleanAttach(request);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		return "redirect:/weekly/list";
	}
	
	//썸네일 이미지 전송
	@GetMapping("/display")
	public ResponseEntity<byte[]> display(String fileName, HttpServletRequest request){

		
		
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		File file = new File(path + "/weeklyImages/" + fileName);
		
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
			File file = new File(path + "/weeklyImages/" + URLDecoder.decode(fileName, "UTF-8"));
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
	public ResponseEntity<List<WeeklyAttach>> uploadAjax(MultipartFile[] uploadFile, HttpServletRequest request) {
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		
		String upPath = path + "/weeklyImages";
		
		List<WeeklyAttach> attachList = new ArrayList<>();
		
		
		
		
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
			
		
			WeeklyAttach adto = new WeeklyAttach();
			
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

>>>>>>> 984fae22bda90814aaa76a1982c84d191da0d745
//
//import java.awt.Graphics2D;
//import java.awt.image.BufferedImage;
//import java.io.File;
//import java.io.IOException;
//import java.io.UnsupportedEncodingException;
//import java.net.URLDecoder;
//import java.nio.file.Files;
//import java.nio.file.Path;
//import java.nio.file.Paths;
//import java.security.Principal;
//import java.text.SimpleDateFormat;
//import java.time.LocalDate;
//import java.time.LocalDateTime;
//import java.time.LocalTime;
//import java.time.ZoneOffset;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.UUID;
//import java.util.stream.Stream;
//
//import javax.imageio.ImageIO;
//import javax.servlet.http.Cookie;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.util.FileCopyUtils;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.church.domain.AlbumPaging;
//import com.church.domain.Weekly;
//import com.church.domain.WeeklyAttach;
//import com.church.service.WeeklyAttachService;
//import com.church.service.WeeklyService;
//
//import net.coobird.thumbnailator.Thumbnailator;
//
//@Controller
//@RequestMapping("/weekly")
//public class WeeklyController {
//	
//	
//	@Autowired
//	private WeeklyService weeklyService;
//	
//	@Autowired
//	private WeeklyAttachService weeklyAttachService;
//	
//	@GetMapping("/add")
//	public String add(@ModelAttribute("weekly") Weekly weekly) {
//		return "/weekly/add";
//	}
//	
//	@PostMapping("/add")
//	public String addWeekly(@RequestParam Map<String, Object> weekly, Principal principal, Model model,
//			@RequestParam("fileName") String[] fileNames,
//            @RequestParam("upFolder") String[] upFolders,
//            @RequestParam("uuid") String[] uuids,
//            @RequestParam("image") String[] images, HttpServletRequest request) {
//		
//		try {
//<<<<<<< HEAD
//			if(principal != null) {
//			String userId = principal.getName();
//			weekly.put("wwriter", userId);
//			}
//			
//			weeklyService.insert(weekly);
//			
//			Weekly recentWeekly = weeklyService.recent();
//			
//			  
//			  if (fileNames != null) {
//				  for (int i = 0; i < fileNames.length; i++) {
//					  Map<String, Object> weeklys = new HashMap<String, Object>();
//					  weeklys.put("wno", recentWeekly.getWno()); 
//					  weeklys.put("fileName", fileNames[i]);
//					  weeklys.put("upFolder", upFolders[i]);
//					  weeklys.put("uuid", uuids[i]);
//					  weeklys.put("image", images[i]);
//					  weeklyAttachService.insertAttach(weeklys);
//				}
//			  }
//			
//			cleanAttach(request);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//=======
//			
//			if(principal != null) {
//				String userId = principal.getName();
//				weekly.put("wwriter", userId);
//				}
//				
//				weeklyService.insert(weekly);
//				
//				Weekly recentWeekly = weeklyService.recent();
//				
//				  
//				  if (fileNames != null) {
//					  for (int i = 0; i < fileNames.length; i++) {
//						  Map<String, Object> weeklys = new HashMap<String, Object>();
//						  weeklys.put("wno", recentWeekly.getWno()); 
//						  weeklys.put("fileName", fileNames[i]);
//						  weeklys.put("upFolder", upFolders[i]);
//						  weeklys.put("uuid", uuids[i]);
//						  weeklys.put("image", images[i]);
//						  weeklyAttachService.insertAttach(weeklys);
//					}
//				  }
//				
//				cleanAttach(request);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//>>>>>>> d0e47c9cfd734bcabadd37072db71fa15e3e741d
//		
//		return "redirect:/weekly/list";
//	}
//	
//	@GetMapping("/delete")
//	public String delete() {
//		return "/weekly/delete";
//	}
//	
//	@ResponseBody
//	@PostMapping("/delete")
//	public void deleteWeekly(@RequestParam String wno, HttpServletRequest request) {
//		try {
//			weeklyService.delete(wno);
//			
//			cleanAttach(request);
//<<<<<<< HEAD
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//=======
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//
//>>>>>>> d0e47c9cfd734bcabadd37072db71fa15e3e741d
//	}
//	
//	@GetMapping("/detail")
//	public String detail(@RequestParam("wno") String wno, Model model,
//			HttpServletRequest request,
//			HttpServletResponse response, Principal principal) {
//        if (wno == null) {
//            HttpSession session = request.getSession();
//            String errorMessage;
//
//            errorMessage = "존재하지 않는 게시물 입니다.<br>다시 이용해주세요.";
//
//            session.setAttribute("errorMessage", errorMessage);
//
//            return "redirect:/weekly/list";
//        }
//		
//
//		
//		try {
//			//주 게시물
//			Weekly weeklyById = weeklyService.detail(wno);
//			model.addAttribute("weekly", weeklyById);
//
//			//첨부파일
//			List<WeeklyAttach> attachList = weeklyAttachService.selectAttachAll(wno);
//			
//			List<String> attachPaths = new ArrayList<String>();
//			
//			for (WeeklyAttach attach : attachList) {
//				
//				String filePath = attach.getUpFolder().replaceAll("\\\\", "/") + "/" + attach.getUuid() + "_" + attach.getFileName();
//				
//
//				attachPaths.add(filePath);
//
//			}
//			
//			model.addAttribute("attachPaths", attachPaths);
//			
//			String username = null;
//			
//			if(principal != null) {
//			String userId = principal.getName();
//			username = userId;
//			}
//			
//			
//			//조회수 증가
//			viewCountValidation(weeklyById, wno, username, request, response);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return "/weekly/detail";
//	}
//	
//		private void viewCountValidation(Weekly weekly, 
//				String wno,
//				String username,
//				HttpServletRequest request, 
//				HttpServletResponse response) {
//				try {
//				Cookie[] cookies = request.getCookies();
//				
//				Cookie cookie = null;
//				boolean isCookie = false;
//				
//				// request에 쿠키들이 있을 때
//				for (int i = 0; cookies != null && i < cookies.length; i++) {
//				// 사용자명_board 쿠키가 있을 때
//				if (cookies[i].getName().equals(username + "_weekly")) {//다른 게시판은 "_weekly" 변경 
//				// cookie 변수에 저장
//				cookie = cookies[i];
//				// 만약 cookie 값에 현재 게시글 번호가 없을 때
//				if (!cookie.getValue().contains("[" + weekly.getWno() + "]")) {
//				// 해당 게시글 조회수를 증가시키고, 쿠키 값에 해당 게시글 번호를 추가
//				weeklyService.updateView(wno);
//				cookie.setValue(cookie.getValue() + "[" + weekly.getWno() + "]");
//				}
//				isCookie = true;
//				break;
//				}
//				}
//				
//				// 만약 사용자명_board라는 쿠키가 없으면 처음 접속한 것이므로 새로 생성
//				if (!isCookie) { 
//					weeklyService.updateView(wno);
//				cookie = new Cookie(username + "_weekly", "[" + weekly.getWno() + "]"); // oldCookie에 새 쿠키 생성
//				}
//				
//				// 쿠키 유지시간을 오늘 하루 자정까지로 설정
//				long todayEndSecond = LocalDate.now().atTime(LocalTime.MAX).toEpochSecond(ZoneOffset.UTC);
//				long currentSecond = LocalDateTime.now().toEpochSecond(ZoneOffset.UTC);
//				cookie.setPath("/"); // 모든 경로에서 접근 가능
//				cookie.setMaxAge((int) (todayEndSecond - currentSecond + 32400));//크롬 UTC 기준 +9시간(32400초) 필요 
//				response.addCookie(cookie);
//				} catch(Exception e) {
//				e.printStackTrace();
//				}
//	}
//	
//	@GetMapping("/list")
//	public String list(Model model, @RequestParam(value = "num",required = false, defaultValue = "1") int num, 
//			@RequestParam(value = "searchType",required = false, defaultValue = "title") String searchType,
//			@RequestParam(value = "keyword",required = false, defaultValue = "") String keyword) throws Exception {
//<<<<<<< HEAD
//=======
//		
//		
//>>>>>>> d0e47c9cfd734bcabadd37072db71fa15e3e741d
//		try {
//			AlbumPaging page = new AlbumPaging();
//			
//			page.setNum(num);
//			page.setCount(weeklyService.searchCount(searchType, keyword));
//			page.setSearchType(searchType);
//			page.setKeyword(keyword);
//
//			List<Weekly> weeklyList = null; 
//			weeklyList = weeklyService.list(page.getDisplayPost(), page.getPostNum(), searchType, keyword);
// 
//			model.addAttribute("weeklyList", weeklyList);
//			model.addAttribute("page", page);
//			model.addAttribute("select", num);
//			
//			
//			Map<Integer, Object> WeeklyAttachList = new HashMap<Integer, Object>();
//			
//			for (Weekly weekly : weeklyList) {
//				WeeklyAttach WeeklyAttach = weeklyAttachService.oneAttach(weekly.getWno());
//				
//				WeeklyAttach.getUpFolder().replaceAll("\\\\", "/");
//				
//				String filePath = WeeklyAttach.getUpFolder().replaceAll("\\\\", "/") + "/" + WeeklyAttach.getUuid() + "_" + WeeklyAttach.getFileName();
//
//				WeeklyAttachList.put(weekly.getWno(), filePath);
//
//			}
//			
//			model.addAttribute("WeeklyAttachList", WeeklyAttachList);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return "/weekly/list";
//	 
//	}	
//	
//	@GetMapping("/modify")
//<<<<<<< HEAD
//	public String modify(@RequestParam String wno, Model model, HttpServletRequest request) {
//        if (wno == null) {
//            HttpSession session = request.getSession();
//            String errorMessage;
//
//            errorMessage = "존재하지 않는 게시물 입니다.<br>다시 이용해주세요.";
//
//            session.setAttribute("errorMessage", errorMessage);
//
//            return "redirect:/weekly/list";
//        }
//		
//		try {
//			//주 게시물
//			Weekly weeklyById = weeklyService.detail(wno);
//			model.addAttribute("weekly", weeklyById);
//
//=======
//	public String modify(@RequestParam String wno, Model model) {
//		
//		try {
//			//주 게시물
//			Weekly weeklyById = weeklyService.detail(wno);
//			model.addAttribute("weekly", weeklyById);
//
//>>>>>>> d0e47c9cfd734bcabadd37072db71fa15e3e741d
//			//첨부파일
//			List<WeeklyAttach> attachList = weeklyAttachService.selectAttachAll(wno);
//			
//			List<String> attachPaths = new ArrayList<String>();
//			
//			for (WeeklyAttach attach : attachList) {
//				
//				String filePath = attach.getUpFolder().replaceAll("\\\\", "/") + "/" + attach.getUuid() + "_" + attach.getFileName();
//				
//
//				attachPaths.add(filePath);
//
//			}
//			
//			model.addAttribute("attachPaths", attachPaths);
//			
//			model.addAttribute("attachList", attachList);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return "/weekly/modify";
//	}
//	
//	@PostMapping("/modify")
//	public String editAlbum(@RequestParam Map<String, Object> weekly, Principal principal, Model model,
//			@RequestParam("fileName") String[] fileNames,
//            @RequestParam("upFolder") String[] upFolders,
//            @RequestParam("uuid") String[] uuids,
//            @RequestParam("image") String[] images, HttpServletRequest request) {
//		
//			try {
//				weeklyService.update(weekly);
//
//				weeklyAttachService.deleteAttach((String) weekly.get("wno"));
//  
//<<<<<<< HEAD
//  if (fileNames != null) {
//				  for (int i = 0; i < fileNames.length; i++) {
//					  Map<String, Object> album = new HashMap<String, Object>();
//					  album.put("wno", weekly.get("wno")); 
//					  album.put("fileName", fileNames[i]);
//					  album.put("upFolder", upFolders[i]);
//					  album.put("uuid", uuids[i]);
//					  album.put("image", images[i]);
//
//					  weeklyAttachService.insertAttach(album);
//				}
//  }
//
//cleanAttach(request);
//=======
//				  if (fileNames != null) {
//								  for (int i = 0; i < fileNames.length; i++) {
//									  Map<String, Object> album = new HashMap<String, Object>();
//									  album.put("wno", weekly.get("wno")); 
//									  album.put("fileName", fileNames[i]);
//									  album.put("upFolder", upFolders[i]);
//									  album.put("uuid", uuids[i]);
//									  album.put("image", images[i]);
//				
//									  weeklyAttachService.insertAttach(album);
//								}
//				  }
//
//			  		cleanAttach(request);
//>>>>>>> d0e47c9cfd734bcabadd37072db71fa15e3e741d
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		
//		return "redirect:/weekly/list";
//	}
//	
//	//썸네일 이미지 전송
//	@GetMapping("/display")
//	public ResponseEntity<byte[]> display(String fileName, HttpServletRequest request){
//
//		
//		
//		
//		String path = request.getSession().getServletContext().getRealPath("/resources/");
//		File file = new File(path + "\\weeklyImages\\" + fileName);
//		
//		ResponseEntity<byte[]> result = null;
//		
//		HttpHeaders header = new HttpHeaders();
//		
//		try {
//			header.add("Content-Type", Files.probeContentType(file.toPath()));
//			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
//		
//		
//		
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return result;
//	}
//	
//	@PostMapping("/deleteFile")
//	public ResponseEntity<String> deleteFile(String fileName, String type, HttpServletRequest request){
//		
//		String path = request.getSession().getServletContext().getRealPath("/resources/");
//		
//		try {
//			File file = new File(path + "\\weeklyImages\\" + URLDecoder.decode(fileName, "UTF-8"));
//			file.delete();	//파일 삭제
//			
//			if(type.equals("image")) {//이미지 파일이면 원본 파일 삭제
//				String originFile = file.getAbsolutePath().replace("s_", "");	//원본 파일명
//				file = new File(originFile);
//				file.delete(); //원본 이미지 삭제
//			}
//			
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//		}
//		
//		return new ResponseEntity<>("deleted", HttpStatus.OK);
//		
//	}
//	
//	@PostMapping("/upload/ajaxAction")
//	public ResponseEntity<List<WeeklyAttach>> uploadAjax(MultipartFile[] uploadFile, HttpServletRequest request) {
//		
//		String path = request.getSession().getServletContext().getRealPath("/resources/");
//		
//		String upPath = path + "\\weeklyImages";
//		
//		List<WeeklyAttach> attachList = new ArrayList<>();
//		
//		
//		
//		
//		// 연/월/일 폴더 생성
//		File upFolder = new File(upPath, getFolder());
//		
//		//업로드 경로에 해당 폴더가 없는 경우에는 생성
//		if( !upFolder.exists() ) {
//			upFolder.mkdirs();
//			
//		}
//		
//		
//		for(MultipartFile multi : uploadFile) {
//		
//			
//			UUID uuid = UUID.randomUUID();
//			
//			String upFileName = uuid + "_" + multi.getOriginalFilename();
//			
////			File saveFile = new File(upPath, multi.getOriginalFilename());
//			File saveFile = new File(upFolder, upFileName);
//			
//		
//			WeeklyAttach adto = new WeeklyAttach();
//			
//			adto.setUpFolder(getFolder());
////			adto.setFileName(upFileName);
//			adto.setFileName(multi.getOriginalFilename());
//			adto.setUuid(uuid.toString());
//			
//			try {
//				multi.transferTo(saveFile); //파일 업로드 처리
//				
//				if(checkImgType(saveFile)) { //이미지 파일의 경우 
//					
//					adto.setImage(true);
//					
////					FileOutputStream fos = new FileOutputStream(new File(upFolder, "s_" + upFileName));
//				
//					// 원본 이미지를 읽어와서 BufferedImage 객체로 변환
//					BufferedImage originalImage = ImageIO.read(multi.getInputStream());
//
//					// 원본 이미지의 크기를 확인하고, 지정한 크기보다 큰 경우에는 축소
//					int originalWidth = originalImage.getWidth();
//					int originalHeight = originalImage.getHeight();
//					if (originalWidth > 100 || originalHeight > 100) {
//					    float scale = Math.min(100f / originalWidth, 100f / originalHeight);
//					    int newWidth = Math.round(originalWidth * scale);
//					    int newHeight = Math.round(originalHeight * scale);
//
//					    BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, originalImage.getType());
//					    Graphics2D g = resizedImage.createGraphics();
//					    g.drawImage(originalImage, 0, 0, newWidth, newHeight, null);
//					    g.dispose();
//
//					    originalImage = resizedImage;
//					}
//
////
////					// 썸네일 이미지 생성
////					File thumbnailFile = new File(upFolder, "s_" + upFileName);
////					Thumbnailator.createThumbnail(originalImage, thumbnailFile, 100, 100);
//					
//					
//					
//					// 썸네일 이미지 생성
//					BufferedImage thumbnail = Thumbnailator.createThumbnail(originalImage, 100, 100);
//					File thumbnailFile = new File(upFolder, "s_" + upFileName);
<<<<<<< HEAD
//					ImageIO.write(thumbnail, "png", thumbnailFile);
//
//					
//					
//					
////					// 썸네일 이미지 생성
////					Thumbnailator.createThumbnail(originalImage, fos, 100, 100);
////					fos.close();
//					
////					   // 썸네일 이미지 압축
////				    Thumbnails.of(new File(upFolder, "s_" + upFileName))
////				              .size(100, 100)
////				              .outputQuality(1.0)
////				              .toFile(thumbnailFile);
//				    
//				    
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		attachList.add(adto);
//		}//END for
//		
//		return new ResponseEntity<>(attachList, HttpStatus.OK);
//		
//		
//		
//	}//END uploadAjax
//	
//	//현재 시점의 '연/월/일' 폴더 경로 문자열 생성하여 반환
//	public String getFolder() {
//		String str = null;
//		try {
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//			str = sdf.format(new Date());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		return str.replace("-", File.separator);
//	}
//	
//	//이미지 파일 여부 확인
//	public boolean checkImgType(File file) {
//		try {
//			String contentType = Files.probeContentType(file.toPath());
//			return contentType.startsWith("image");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return false;
//		
//	}
//	
//	@GetMapping("/attachList") // 첨부파일 목록
//	public ResponseEntity<List<WeeklyAttach>> attachList(String wno) {
//		
//		//첨부파일 목록과 200번 코드 반환
//		return new ResponseEntity<>(weeklyAttachService.selectAttachAll(wno), HttpStatus.OK);
//	
//	}
//	
//	public void deleteAttach(List<WeeklyAttach> attachList, HttpServletRequest request){ //첨부파일 삭제
//		
//		String path = request.getSession().getServletContext().getRealPath("/resources/");
//		
//		if (attachList == null || attachList.size() < 1) {
//			return;
//			
//		}
//		
//		
//		attachList.forEach(abvo -> {
//			try {
//			Path file = Paths.get(path + "\\weeklyImages\\" + abvo.getUpFolder() + "\\" + abvo.getUuid() + "_" + abvo.getFileName());
//			
//				Files.deleteIfExists(file); //파일이 존재하면 삭제
////				Files.exists(path)
//			
//			if (Files.probeContentType(file).startsWith("image")) { //이미지 파일의 경우
//				Path thumbnail = Paths.get(path + "\\weeklyImages\\" + abvo.getUpFolder() + "\\s_" + abvo.getUuid() + "_" + abvo.getFileName());
//				Files.delete(thumbnail); //썸네일 삭제
//			}
//			
//			} catch (IOException e) {
//				e.printStackTrace();
//			} 
//			
//		});
//		
//	}
//	
//	public void cleanAttach(HttpServletRequest request){ //DB에 있는 데이터와 폴더에 있는 첨부파일이 일치하는 것들 이외에 삭제
//		
//		String path = request.getSession().getServletContext().getRealPath("/resources/");
//		
//		List<WeeklyAttach> attachList = weeklyAttachService.allFiles();
//		
//		if (attachList == null || attachList.size() < 1) {
//			return;
//			
//		}
//
//	    try (Stream<Path> files = Files.walk(Paths.get(path + "\\weeklyImages\\"))) {
//	        files.filter(file -> {
//	                // DB에 존재하는 파일 리스트에 포함되어 있지 않으면 true 반환
//	                return attachList.stream()
//	                                 .noneMatch(dbFile -> Paths.get(path + "\\weeklyImages\\" + dbFile.getUpFolder() + "\\" + dbFile.getUuid() + "_" + dbFile.getFileName()).equals(file)
//	                                           || Paths.get(path + "\\weeklyImages\\" + dbFile.getUpFolder() + "\\s_" + dbFile.getUuid() + "_" + dbFile.getFileName()).equals(file));
//	            })
//	            .forEach(file -> {
//	                try {
//	                    Files.delete(file);
//	                } catch (IOException e) {
//	                    e.printStackTrace();
//	                }
//	            });
//	    } catch (IOException e) {
//	        e.printStackTrace();
//	    }
//		
//		
//		
//	}
//	
//
//}
=======
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
		String str = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			str = sdf.format(new Date());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
	public ResponseEntity<List<WeeklyAttach>> attachList(String wno) {
		
		//첨부파일 목록과 200번 코드 반환
		return new ResponseEntity<>(weeklyAttachService.selectAttachAll(wno), HttpStatus.OK);
	
	}
	
	public void deleteAttach(List<WeeklyAttach> attachList, HttpServletRequest request){ //첨부파일 삭제
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		
		if (attachList == null || attachList.size() < 1) {
			return;
			
		}
		
		
		attachList.forEach(abvo -> {
			try {
			Path file = Paths.get(path + "/weeklyImages/" + abvo.getUpFolder() + "/" + abvo.getUuid() + "_" + abvo.getFileName());
			
				Files.deleteIfExists(file); //파일이 존재하면 삭제
//				Files.exists(path)
			
			if (Files.probeContentType(file).startsWith("image")) { //이미지 파일의 경우
				Path thumbnail = Paths.get(path + "/weeklyImages/" + abvo.getUpFolder() + "/s_" + abvo.getUuid() + "_" + abvo.getFileName());
				Files.delete(thumbnail); //썸네일 삭제
			}
			
			} catch (IOException e) {
				e.printStackTrace();
			} 
			
		});
		
	}
	
	public void cleanAttach(HttpServletRequest request){ //DB에 있는 데이터와 폴더에 있는 첨부파일이 일치하는 것들 이외에 삭제
		
		String path = request.getSession().getServletContext().getRealPath("/resources/");
		
		List<WeeklyAttach> attachList = weeklyAttachService.allFiles();
		
		if (attachList == null || attachList.size() < 1) {
			return;
			
		}

	    try (Stream<Path> files = Files.walk(Paths.get(path + "/weeklyImages/"))) {
	        files.filter(file -> {
	                // DB에 존재하는 파일 리스트에 포함되어 있지 않으면 true 반환
	                return attachList.stream()
	                                 .noneMatch(dbFile -> Paths.get(path + "/weeklyImages/" + dbFile.getUpFolder() + "/" + dbFile.getUuid() + "_" + dbFile.getFileName()).equals(file)
	                                           || Paths.get(path + "/weeklyImages/" + dbFile.getUpFolder() + "/s_" + dbFile.getUuid() + "_" + dbFile.getFileName()).equals(file));
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
>>>>>>> 984fae22bda90814aaa76a1982c84d191da0d745
