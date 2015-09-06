package com.neighbourhood.test;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.neighbourhood.neighbours.GetParsedNeighbours;
import com.neighbourhood.user.User;

public class TestParsedNeighbourList {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		
		Map<String,List<User>> parsedNeighbourMap =GetParsedNeighbours.getParsedNeighboursForUser("ankurgupta85");
		Iterator it = parsedNeighbourMap.entrySet().iterator();
		while(it.hasNext())
		{
			Map.Entry<String, List<User>> pairs=(Map.Entry<String, List<User>>) it.next();
			
			System.out.println("For Zipcode "+pairs.getKey() + " Users are ");
			List<User> userList = pairs.getValue();
			for(int i=0;i<userList.size();i++)
			{
				System.out.println("Username "+userList.get(i).getUsername());
			}
			
			
			
		}
	}

}
