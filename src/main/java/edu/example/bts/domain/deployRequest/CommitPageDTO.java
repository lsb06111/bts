package edu.example.bts.domain.deployRequest;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommitPageDTO {

	private List<CommitDTO> commitList;
	private int currentPage;
	private boolean hasNext;
	private int totalPage;
}
