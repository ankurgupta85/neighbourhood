package com.neighbourhood.security;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

public final class EncryptDecryptData {

	SecureData secureData = null;

	final public List<String> encryptData(String username, List<String> input)
			throws InvalidKeyException, UnsupportedEncodingException,
			NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidAlgorithmParameterException, IllegalBlockSizeException,
			BadPaddingException {
		List<String> output = new ArrayList<String>();

		secureData = new SecureData();

		output = secureData.encryptData(username, input);
		return output;
	}

	final public List<String> decryptData(String username, List<String> input)
			throws InvalidKeyException, NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidAlgorithmParameterException,
			IllegalBlockSizeException, BadPaddingException, IOException {
		List<String> output = new ArrayList<String>();

		secureData = new SecureData();

		output = secureData.decryptData(username, input);
		return output;
	}


}
