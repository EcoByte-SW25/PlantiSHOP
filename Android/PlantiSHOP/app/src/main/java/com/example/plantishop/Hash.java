package com.example.plantishop;

import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;

public class Hash {

    @SuppressWarnings("FieldMayBeFinal")
    private KeyPair kk;
    @SuppressWarnings("FieldMayBeFinal")
    private IvParameterSpec iv;

    public Hash() throws Exception {
        // Conexión al KGS
        kk = null;
        iv = null;
    }

    public String cifrar(String txt) throws Exception {
        Cipher c = Cipher.getInstance("RSA");
        c.init(Cipher.ENCRYPT_MODE, kk.getPublic(), iv);
        return new String(c.doFinal(txt.getBytes(StandardCharsets.UTF_8)));
    }

    public String descifrar(String hashed) throws Exception {
        Cipher c = Cipher.getInstance("RSA");
        c.init(Cipher.DECRYPT_MODE, kk.getPrivate(), iv);
        return new String(c.doFinal(hashed.getBytes(StandardCharsets.UTF_8)));
    }

}