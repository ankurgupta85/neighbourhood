package com.neighbourhood.test;

import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import com.neighbourhood.security.EncryptDecryptData;

public class TestEncryption {

	/**
	 * @param args
	 * @throws BadPaddingException 
	 * @throws IllegalBlockSizeException 
	 * @throws InvalidAlgorithmParameterException 
	 * @throws NoSuchPaddingException 
	 * @throws NoSuchAlgorithmException 
	 * @throws InvalidKeyException 
	 * @throws IOException 
	 */
	public static void main(String[] args) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Test Started");
		EncryptDecryptData edData = new EncryptDecryptData();
		String username="ankurgupta85";
		String text = "Hello World";
		System.out.println("Input Text "+text);
		List<String> input = new ArrayList<String>();
		input.add(text);
		input.add("Bye World");
		assert(edData.encryptData(username, input).size() == 2);
		List<String> encryptedData = edData.encryptData(username, input);

		assert(encryptedData.size() == 2);
		
		String encryptedDataString = encryptedData.get(0);
		System.out.println("Encrypted String "+encryptedDataString);
		encryptedDataString = encryptedData.get(1);
		System.out.println("Encrypted String "+encryptedDataString);
		input.clear();
		input.add(encryptedDataString);
		String decryptedData = ((List<String>)edData.decryptData(username, input)).get(0);
		System.out.println("Decrypted String "+decryptedData);
		assert(decryptedData.equals(text));
		System.out.println("Test Completed");
	}

}
