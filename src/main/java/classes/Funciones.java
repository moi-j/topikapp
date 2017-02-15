/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.security.SecureRandom;
import java.math.BigInteger;
import java.text.ParseException;


/**
 *
 * @author Usher
 */
public class Funciones {
  private static SecureRandom random = new SecureRandom();
  
  public static String clave() {
    return new BigInteger(130, random).toString(32);
  }
  
  public static String convierteFecha(Date fecha) throws ParseException{
    // Setting the pattern
    SimpleDateFormat sm = new SimpleDateFormat("dd-MM-yyyy");
    // Converting it into String using formatter
    String strDate = sm.format(fecha);

    return strDate;
  }
  
  public static String dbAddress(){
    //return "127.12.49.130";
    return "localhost";
  }
}
