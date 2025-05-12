package com.example.plantishop;

public class Cortes {

    public static volatile String sesion;

    private final char[] cs = {
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            '+', '-', '*', '/', 'A', 'B', 'C', 'D', 'E', 'F',
            'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
            'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    };

    public String cV() {
        boolean k;
        char c;
        String cV = "";
        for (byte i = 1; i < 11; i++) {
            do {
                try {
                    k = false;
                    c = cs[Math.round((float) (Math.random() * 100d))];
                    for (char x : cV.toCharArray()) {
                        if (x == c) {
                            k = true;
                            break;
                        }
                    }
                    if (!k) {
                        cV += c;
                    }
                } catch (IndexOutOfBoundsException e) {
                    k = true;
                }
            } while (k);
        }
        return cV;
    }

}