package com.neighbourhood.neighbours;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.neighbourhood.user.User;

public class GetParsedNeighbours {

	
	public static Map<String,List<User>> getParsedNeighboursForUser(String username)
	{
		
		List<User> neighbourList = Neighbours.getNeighboursList(username); 
		
		Map<String,List<User>> parsedNeighbourMap=getParsedNeighboursList(neighbourList);
		
		
		return parsedNeighbourMap;
	}
	
	public static List<User> getParsedNeighboursByZipcode(List<User> neighbourList,String zipcode)
	{
		List<User> newList=new ArrayList<User>();
		for(int index=0;index<neighbourList.size() ; index++)
		{
			
			User user = neighbourList.get(index);
			
			if(user.getZipcode().equals(zipcode))
			{
				newList.add(user);
			}
			
			
		}
		
		
		
		
		
		
		
		
		return (List<User>)newList;
	}
	
	

	public static int getSizeOfParsedNeighboursByZipcode(List<User> neighbourList,String zipcode)
	{
		List<User> newList= getParsedNeighboursByZipcode(neighbourList, zipcode);
		
		
		return newList.size();
	}
	
	
	
	private static Map<String,List<User>> getParsedNeighboursList(List<User> neighbourList)
	{
		
		Map<String,List<User>> parsedNeighbourMap = new HashMap<String,List<User>>();
		List<String> getZipcodeList = (List<String>)parseZipCodeList(neighbourList);
 		// Code to traverse through zipcode list and store users in map as per zipcode
		// need to determine efficient way 
		// one way is to go through list for each zipcode and create a list of users but that needs traversal of whole list for new zipcode
		
		for(int i=0;i<getZipcodeList.size();i++)
		{
			List<User> newList=new ArrayList<User>();
			String zipcode=getZipcodeList.get(i);
			for(int j=0;j<neighbourList.size();j++)
			{
				User user=neighbourList.get(j);
				if(user.getZipcode().equals(zipcode))
				{
					newList.add(user);
					
				//	neighbourList.remove(j);
					
				}
				else
				{
					continue;
				}
				
				
				
				
			}
			parsedNeighbourMap.put(zipcode, newList);
			
			
			
			
			
		}
		
		
		
		
		
		return parsedNeighbourMap;
	}
	
	
	public static List<String> parseZipCodeList(List<User> neighList)
	{
		List<String> zipcodeList=new ArrayList<String>();
		for(int i =0;i<neighList.size() ; i++)
		{
			User user=neighList.get(i);
			String zipcode=user.getZipcode();
			if(zipcodeList.contains(zipcode))
			{
				continue;
			}
			else
			{
				zipcodeList.add(zipcode);
			}
			
			
		}
		
		return zipcodeList;
				
		
		
		
	}
	
	
}
