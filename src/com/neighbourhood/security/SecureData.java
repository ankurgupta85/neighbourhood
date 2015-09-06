package com.neighbourhood.security;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import sun.misc.BASE64Encoder;

final class SecureData {

	private final String SALT = "23FGEHI67";

final String getCombination(String username) {
		String combination = SALT + username;
		StringBuffer buff = new StringBuffer(combination);
		if (combination.length() < 16) {
			buff.append("kjweqaasqwdf");
		}
		combination = buff.toString();
		return combination;
	}

	final AlgorithmParameterSpec getParamSpec(String combination)
			throws UnsupportedEncodingException {
		return new IvParameterSpec(combination.getBytes("UTF-8"), 0, 16);

	}

	final SecretKeySpec getKey(String digest) {
		return new SecretKeySpec(digest.getBytes(), "AES");
	}

	final String generateDigest(String text, int count)
			throws NoSuchAlgorithmException, UnsupportedEncodingException {
		if (count == 1000) {
			return text;
		}
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] textbytes = text.getBytes("UTF-8");

		// System.out.println("Byte Array: "+ new String(textbytes));

		md.update(textbytes);
		// System.out.println("Original Text : "+text);
		String digest = new String(md.digest());

		// System.out.println("Digest: "+ digest);
		count++;
		return generateDigest(digest, count);

	}

	final List<String> encryptData(String username, List<String> input)
			throws UnsupportedEncodingException, NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidKeyException,
			InvalidAlgorithmParameterException, IllegalBlockSizeException,
			BadPaddingException {
		List<String> output = new ArrayList<String>();
		String combination = getCombination(username);
		String digest = generateDigest(combination, 0);
		// System.out.println("Digest "+ digest);

		SecretKeySpec key = getKey(digest);
		AlgorithmParameterSpec paramSpec = getParamSpec(combination);
		// Whatever you want to encrypt/decrypt
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

		// You can use ENCRYPT_MODE (ENCRYPTunderscoreMODE) or DECRYPT_MODE
		// (DECRYPT underscore MODE)
		cipher.init(Cipher.ENCRYPT_MODE, key, paramSpec);

		for (String inputString : input) {
			// encrypt data
			byte[] encrypted = cipher.doFinal(inputString.getBytes("UTF-8"));

			// encode data using standard encoder
			String outputString = new BASE64Encoder().encode(encrypted);
			output.add(outputString);

		}

		return (List<String>) output;
	}

final List<String> decryptData(String username, List<String> input)
			throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException, IOException {

		List<String> output = new ArrayList<String>();

		String combination = getCombination(username);
		String digest = generateDigest(combination, 0);
		// System.out.println("Digest "+ digest);

		SecretKeySpec key = getKey(digest);
		AlgorithmParameterSpec paramSpec = getParamSpec(combination);
		// Whatever you want to encrypt/decrypt
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

		// You can use ENCRYPT_MODE (ENCRYPTunderscoreMODE) or DECRYPT_MODE
		// (DECRYPT underscore MODE)
		cipher.init(Cipher.DECRYPT_MODE, key, paramSpec);

		for (String inputString : input) {
			// decode data using standard encoder
			byte[] outputString = new Base64().decode(new String(inputString));
			byte[] decrypted = cipher.doFinal(outputString);
			output.add(new String(decrypted));
		}

		return (List<String>) output;

	}




}
