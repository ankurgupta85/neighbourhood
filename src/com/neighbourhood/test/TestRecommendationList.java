package com.neighbourhood.test;

import java.util.List;

import com.neighbourhood.recommendation.RecommendationList;
import com.neighbourhood.user.User;

public class TestRecommendationList {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		
		List<User> getList=RecommendationList.getRecommendation("ankurgupta85",94090);
		System.out.println(getList);
		//getList=RecommendationList.updateRecommendationList(getList, "vinay");
		//System.out.println(getList);
		
	}

}
