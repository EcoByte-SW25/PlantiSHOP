package auxs;

import javax.crypto.spec.PBEKeySpec;
import javax.crypto.SecretKeyFactory;

public class Hash {
    
    public String hashPBKDF2(String txt) throws Exception {
        return new String(SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(new PBEKeySpec(txt.toCharArray())).getEncoded());
    }
    
}