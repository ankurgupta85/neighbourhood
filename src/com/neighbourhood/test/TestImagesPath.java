package com.neighbourhood.test;

import com.neighbourhood.user.RetrieveMessage;
import com.neighbours.imageUpload.RetrieveImage;

public class TestImagesPath {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		String path=RetrieveImage.getProfileImagePath("ankurgupta85");
		System.out.println(path);
		
		
		
	}

}
