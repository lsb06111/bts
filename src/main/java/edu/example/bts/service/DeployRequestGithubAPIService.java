package edu.example.bts.service;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Arrays;

import org.kohsuke.github.GHCommit;
import org.kohsuke.github.GHCommit.File;
import org.kohsuke.github.GHCompare;
import org.kohsuke.github.GHContent;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.kohsuke.github.PagedIterable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.difflib.DiffUtils;
import com.github.difflib.patch.AbstractDelta;
import com.github.difflib.patch.DeltaType;
import com.github.difflib.patch.Patch;

import edu.example.bts.dao.DeployRequestDAO;
import edu.example.bts.domain.deployRequest.CommitDTO;
import edu.example.bts.domain.deployRequest.CommitFileDTO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DeployRequestGithubAPIService {

	// Github API 헤더 (공통) 
	
	@Autowired
	private DeployRequestDAO dao;
	
	//Github repo의 commitList 가져오기
	public List<CommitDTO> getCommitList(String ownerName, String repoName, String token)  {
		/*
		String url = "https://api.github.com/repos/"+ ownerName +"/"+ repoName + "/commits";
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Accept", "application/vnd.github+json");
		headers.setBearerAuth(token);		// headers.set("Authorization", "Bearer " + token);
		headers.set("X-GitHub-Api-Version", "2022-11-28");
		
		HttpEntity<Void> request = new HttpEntity<>(headers);	// 요청
		RestTemplate restTemplate = new RestTemplate();
		*/
		List<CommitDTO> commitList = new ArrayList<CommitDTO>();

		try {
			GitHub github = new GitHubBuilder().withOAuthToken(token).build();
			GHRepository repository = github.getRepository(ownerName + "/" + repoName);
			PagedIterable<GHCommit> ghcommitList = repository.listCommits();
			
			int count= 0;
			for(GHCommit commit : ghcommitList) {
				Date date = commit.getCommitShortInfo().getAuthor().getDate();     //Date authorDate = commit.getCommitShortInfo().getAuthoredDate();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm");
				
				String sha = commit.getSHA1();
				String commitMessage = commit.getCommitShortInfo().getMessage();
				String authorName = commit.getCommitShortInfo().getAuthor().getName();    //String authorName = commit.getAuthor().getLogin();
				String authorDate = dateFormat.format(date);
				
				String userName = dao.findEmpNameByGitId(authorName);
				
				CommitDTO dto = new CommitDTO(sha, commitMessage, authorName, authorDate, userName);
				commitList.add(dto);

				if(++count>10) break;  // 10개만 출력중... DB쪽을 너무 많이 다녀오는데 생각좀;;; 
			}
			
		}catch(Exception e) {
			System.err.println("Github API 호출중 에러 발생 : " + e.getMessage() );
		}
		
		return commitList;
	}

	// 선택한 커밋에 해당하는 파일정보 가져오기
	public List<CommitFileDTO> getCommitDetail(String ownerName, String repoName, String token, String sha) {
		List<CommitFileDTO> fileList = new ArrayList<>();
		try {
			GitHub github = new GitHubBuilder().withOAuthToken(token).build();
			GHRepository repository = github.getRepository(ownerName + "/" + repoName);
			GHCommit commit = repository.getCommit(sha);
			List<GHCommit.File> commitFileList = commit.getFiles();
		
			for(File file : commitFileList) {
				String fileSha = file.getSha();  // 파일SHA와 커밋 SHA는 다름 
				String fileName = file.getFileName();
				int lineAdded = file.getLinesAdded();
				int lineDeleted = file.getLinesDeleted();
				String status = file.getStatus();
				String patch = file.getPatch();
				
				CommitFileDTO dto = new CommitFileDTO(sha, fileSha, fileName, lineAdded, lineDeleted, status, patch);
				
				fileList.add(dto);
				//System.out.println("fileSHA: " + fileSha);
				//System.out.println("fileName: " + fileName);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return fileList;
		
	}

	
// 같은 파일의 커밋 목록(sha)가져오기 
	public List<String> getFileCommitList(String ownerName, String repoName, String token, String fileName) {
		List<String> fileShaList = new ArrayList<>();
		try {
			GitHub github = new GitHubBuilder().withOAuthToken(token).build();
			GHRepository repository = github.getRepository(ownerName + "/" + repoName);
			PagedIterable<GHCommit> queryCommitPath = repository.queryCommits().path(fileName).list();
					
			for(GHCommit fileCommit : queryCommitPath) {
				//System.out.println(fileCommit + "-" + fileCommit.getSHA1());
				fileShaList.add(fileCommit.getSHA1());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fileShaList;
	}

	public String compareFileWithCommitSha(String ownerName, String repoName, String token, String fileName, String sha,
			String compareSha) {

		String diffPatch = "";

		try {
			GitHub gitHub = new GitHubBuilder().withOAuthToken(token).build();
			GHRepository repository = gitHub.getRepository(ownerName + "/" + repoName);
			
			GHCompare GHCompare = repository.getCompare(compareSha, sha);
			//System.out.println("jjjjjj : " + GHCompare.getDiffUrl());
			//System.out.println("jjjjjj : " + GHCompare.getFiles());
			
			for ( File file : GHCompare.getFiles()) {
				System.out.println(file.getFileName().equals(fileName));
				if(file.getFileName().equals(fileName)) {
					//System.out.println("diff 내용:\n" + file.getPatch());
					diffPatch = file.getPatch();
				}
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return diffPatch;
	}

	public Map<String, Object> compareFileWithCommitSha3(String ownerName, String repoName, String token, String fileName,
			String sha, String compareSha) {
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			GitHub github = new GitHubBuilder().withOAuthToken(token).build();
			GHRepository repository = github.getRepository(ownerName+"/"+repoName);

			
			// 최근커밋(변경후)
			GHContent headFile = repository.getFileContent(fileName, sha);
			//String revised = headFile.getContent();   // headFile.read().readAllBytes() : java9
			List<String> revised = Arrays.asList(headFile.getContent().split("\n"));

			
			// 비교할 커밋(변경전:선택한거)
			GHContent baseFile = repository.getFileContent(fileName, compareSha);
			//String original = baseFile.getContent();
			List<String> original = Arrays.asList(baseFile.getContent().split("\n"));
			
			
			// 비교 (문자단위):String  => 보류 
			//Patch<String> patch = DiffUtils.diffInline(original, revised);
			//System.out.println(patch.getDeltas());
			Patch<String> patch = DiffUtils.diff(original, revised);
			//System.out.println(patch.getDeltas());
			
			
			
			
			//줄이 달라서 보기 힘듬... ----
			List<Integer> insertLines = new ArrayList<>();
			List<Integer> deleteLines = new ArrayList<>();
			List<Integer> changeLinesRev = new ArrayList<>();
			List<Integer> changeLinesRevOri = new ArrayList<>();
			
			for(AbstractDelta<String> delta : patch.getDeltas()){
				System.out.println(delta.getType());
				System.out.println(delta.getSource());		// 이전(Base)
				System.out.println(delta.getTarget()); 		// 최근(Head)
			
				DeltaType type = delta.getType();
				System.out.println();
				int revPosition = delta.getTarget().getPosition();
				int revLastPosition = delta.getTarget().last();	// // getPosition()+size()-1
				System.out.println(revPosition + ", " + revLastPosition);
				
				int oriPosition = delta.getSource().getPosition();
				int oriLastPosition = delta.getSource().last();
				System.out.println(oriPosition +", " + oriLastPosition);
				
				if(type == DeltaType.INSERT) {
					for(int i = revPosition; i<revLastPosition+1; i++) {
						insertLines.add(i);
					}					
				}else if(type == DeltaType.DELETE) {
					for(int i= oriPosition; i<oriLastPosition+1; i++) {
						deleteLines.add(i);
					}
					
				}else if(type == DeltaType.CHANGE) {
					//head
					for(int i = revPosition; i<revLastPosition+1; i++) {
						changeLinesRev.add(i);
					}
					//base
					for(int i=oriLastPosition; i<oriLastPosition+1; i++) {
						changeLinesRevOri.add(i);
					}
				}

				result.put("originalCode", String.join("\n", original));
				result.put("revisedCode", String.join("\n", revised));

				result.put("changeRev", changeLinesRev);
				result.put("insertIndex", insertLines);
				result.put("deleteIndex", deleteLines);
				result.put("changeOri", changeLinesRevOri);			
			}
			

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	
	public Map<String, Object> compareFileWithCommitSha4(String ownerName, String repoName, String token, String fileName,
			String sha, String compareSha) {
		
		Map<String, Object> result = new HashMap<>();
		System.out.println("4번인가요?");
		try {
			GitHub github = new GitHubBuilder().withOAuthToken(token).build();
			GHRepository repository = github.getRepository(ownerName+"/"+repoName);

			
			// 최근커밋(변경후)
			GHContent headFile = repository.getFileContent(fileName, sha);
			List<String> revised = Arrays.asList(headFile.getContent().split("\n"));

			
			// 비교할 커밋(변경전:선택한거)
			GHContent baseFile = repository.getFileContent(fileName, compareSha);
			List<String> original = Arrays.asList(baseFile.getContent().split("\n"));
			
			
			// 비교 (문자단위):String  => 보류 
			Patch<String> patch = DiffUtils.diff(original, revised);   
			List<AbstractDelta<String>> dt = patch.getDeltas();    // 변경전  파일(original)기준으로 알려줌 
			

			System.out.println("****확인중입니다 ******");
			int o=0;
			int r=0;
			
			List<Map<String, Object>> delta = new ArrayList<>();
			for(AbstractDelta<String> d : dt) {
				Map<String, Object> block = new HashMap<>();

				DeltaType type = d.getType();
				// 변경전(ori:base)
				System.out.println("base : " + d.getSource());  
				int baseStartNum = d.getSource().getPosition();
				int baseEndNum = d.getSource().last();
				List<String> baseLines =  d.getSource().getLines();
				
				// 변경후(rev:head)
				System.out.println("head : " + d.getTarget());
				int headStartNum = d.getTarget().getPosition();
				int headEndNum = d.getTarget().last();
				List<String> headLines = d.getTarget().getLines();
				
				
				while(o<baseStartNum) {
					log.info("{}", String.format("[%-3s]%-100s |[%-3s]%-100s",o+1 ,original.get(o),r+1 ,revised.get(r)));
					o++;
					r++;
					
				}
				
				switch (d.getType()) {
				case INSERT:
					log.info("insert");
					for(int i=0; i<headLines.size(); i++) {
						log.info("{}", String.format("[%-3s]%-100s | [%-3s]%-100s", "","",r+1, headLines.get(i)));											
					
					r++;
					}
					break;
				case DELETE:
					log.info("delete");
					for(int i=0; i<baseLines.size(); i++) {
						log.info("{}", String.format("[%-3s]%-100s | [%-3s]%-100s", o+1,baseLines.get(i),"", ""));					
					o++;
					}
					break;
				case CHANGE:
					log.info("CHANGE");
					if(headLines.size() == baseLines.size()){
						log.info("{}", String.format("[%-3s]%-100s |[%-3s]%-100s",o+1 ,original.get(o),r+1 ,revised.get(r)));
						o++;
						r++;
					}else if(headLines.size() < baseLines.size()){
						for(int i=0; i<headLines.size(); i++) {
							log.info("{}", String.format("[%-3s]%-100s |[%-3s]%-100s",o+1 ,original.get(o),r+1 ,revised.get(r)));
							o++;
							r++;
						}
						for(int i=headLines.size();i<baseLines.size(); i++) {
							log.info("{}", String.format("[%-3s]%-100s | [%-3s]%-100s", o+1,baseLines.get(i),"", ""));	
							o++;
						}
					} else if(headLines.size() > baseLines.size()) {
						for(int i=0; i<baseLines.size(); i++) {
							log.info("{}", String.format("[%-3s]%-100s |[%-3s]%-100s",o+1 ,original.get(o),r+1 ,revised.get(r)));
							o++;
							r++;
						}
						for(int i=baseLines.size(); i<headLines.size(); i++) {
							log.info("{}", String.format("[%-3s]%-100s | [%-3s]%-100s", "","",r+1, headLines.get(i)));	
							r++;
						}
					}
					
				/*	for(int i=0; i<baseLines.size(); i++) {
						log.info("{}", String.format("[%-3s]%-100s | [%-3s]%-100s", o+1,baseLines.get(i),"", ""));					
					o++;
					}
					for(int i=0; i<headLines.size(); i++) {
						log.info("{}", String.format("[%-3s]%-100s | [%-3s]%-100s", "","",r+1, headLines.get(i)));											
					
					r++;
					}*/
					break;
				default:
					break;
				}
				
				block.put("type", type);
				block.put("baseStartNum", baseStartNum);
				//block.put("baseEndNum", baseEndNum);
				block.put("baseLines", baseLines);
				block.put("headStartNum", headStartNum);
				//block.put("headEndNum", headEndNum);
				block.put("headLines", headLines);
				
				delta.add(block);
			}
			
			result.put("delta", delta);
			result.put("originalCode", original);
			result.put("revisedCode", revised);

		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	
}
