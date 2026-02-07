package webinvoice;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.KeyException;
import java.io.UnsupportedEncodingException;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import javax.crypto.NoSuchPaddingException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;
import java.security.Key;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.crypto.Cipher;

public class CBDCrypto {
	
	private  final String characterEncoding = "UTF-8";
    private  final String cipherTransformation = "AES/CBC/PKCS5Padding";
    private  final String aesEncryptionAlgorithm = "AES";
    
    public  byte[] decrypt(byte[] cipherText, final byte[] key, final byte[] initialVector) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        final Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        final SecretKeySpec secretKeySpecy = new SecretKeySpec(key, "AES");
        final IvParameterSpec ivParameterSpec = new IvParameterSpec(initialVector);
        cipher.init(2, secretKeySpecy, ivParameterSpec);
        cipherText = cipher.doFinal(cipherText);
        return cipherText;
    }
    
    public  byte[] encrypt(byte[] plainText, final byte[] key, final byte[] initialVector) throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        final Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        final SecretKeySpec secretKeySpec = new SecretKeySpec(key, "AES");
        final IvParameterSpec ivParameterSpec = new IvParameterSpec(initialVector);
        cipher.init(1, secretKeySpec, ivParameterSpec);
        plainText = cipher.doFinal(plainText);
        return plainText;
    }
    
    private  byte[] getKeyBytes(final String key) throws UnsupportedEncodingException {
        final byte[] keyBytes = new byte[16];
        final byte[] parameterKeyBytes = key.getBytes("UTF-8");
        System.arraycopy(parameterKeyBytes, 0, keyBytes, 0, Math.min(parameterKeyBytes.length, keyBytes.length));
        return keyBytes;
    }
    
    public String encrypt(final String plainText, final String key) throws UnsupportedEncodingException, InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        final byte[] plainTextbytes = plainText.getBytes("UTF-8");
        final byte[] keyBytes = getKeyBytes(key);
        Base64 base64=new Base64();
        return base64.encodeToString(encrypt(plainTextbytes, keyBytes, keyBytes), 0);
    }
    
    public String decrypt(final String encryptedText, final String key) throws KeyException, GeneralSecurityException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, IOException {
        final byte[] cipheredBytes = Base64.decode(encryptedText, 0);
        final byte[] keyBytes = getKeyBytes(key);
        return new String(decrypt(cipheredBytes, keyBytes, keyBytes), "UTF-8");
    }
}
