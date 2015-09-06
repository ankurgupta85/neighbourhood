package com.neighbours.imageUpload;

import java.io.File;

public class CreateImageFolder {
	
	public static void createImageFolder(String username)
	{
		
		try
		{
		String fullPath="C:\\Users\\agupta2\\Desktop\\eclipse\\workspace\\Neighbourhood\\WebContent\\images_users\\";
		File f=new File(fullPath+username+"\\");
		boolean directoryFound=false;
		if(f.exists())
		{
			directoryFound=true;
		}
		
		
		if(!directoryFound)
		{
			File f1=new File(fullPath+username+"\\");
			f1.mkdir();
			f1.setWritable(true);
		
		}
		
		
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}

}

}