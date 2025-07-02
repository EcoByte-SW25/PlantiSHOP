package auxs;

import java.security.MessageDigest;

public class Hash {
    
    public String hashSHA256(String txt) throws Exception {
        byte[] hash = MessageDigest.getInstance("SHA-256").digest(txt.getBytes("UTF-8"));
        String hashed = "";
        for (byte h : hash) {
            hashed += String.format("%02x", h);
        }
        return hashed;
    }
    
}