/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import Modelo.listaanime;
import Modelo.musuario;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;


public class ConexionAPI {
    
    public static final String url = "http://localhost:4000";
    
    public static JSONObject peticionPost(String urll, JSONObject data)throws Exception{
        String charset = "UTF-8"; 
        StringBuilder resultado = new StringBuilder();
        URLConnection connection = new URL(url + urll).openConnection();
        connection.setDoOutput(true);
        connection.setRequestProperty("Accept-Charset", charset);
        connection.setRequestProperty("Content-Type", "application/json;charset=" + charset);
        try (OutputStream output = connection.getOutputStream()) {
          output.write(data.toString().getBytes(charset));
        }
        BufferedReader rd = new BufferedReader(new InputStreamReader (connection.getInputStream()));
        String linea;
        while ((linea = rd.readLine()) != null) {
                resultado.append(linea);
        }
        rd.close();
        
        return new JSONObject(resultado.toString());
    }
    
    public static boolean registrar(musuario usu){
        try{
            JSONObject js = new JSONObject();
            //nombre, correo, contra
            js.put("nombre", usu.getNom_usu());
            js.put("correo", usu.getEmail_usu());
            js.put("contra", usu.getContra_usu());
            String di = "/registrar";
            JSONObject jr = peticionPost(di, js);
            String status = jr.getString("status");
            if(status.equals("registrado")){
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            System.out.println(e.getCause());
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public static musuario iniciar(String email, String contra){
        musuario usu = new musuario();
        usu.setNom_usu("no encontrado");
        try{
            JSONObject js = new JSONObject();
            // correo, contra
            js.put("correo", email);
            js.put("contra", contra);
            String di = "/iniciarsesion";
            JSONObject jr = peticionPost(di, js);
            String status = jr.getString("status");
            if(status.equals("encontrado")){
                JSONObject us = jr.getJSONObject("usuario");
                usu.setNom_usu(us.getString("nom_usu"));
                usu.setId_usu(us.getInt("id_usu"));
            }
        }catch(Exception e){
            System.out.println(e.getCause());
            System.out.println(e.getMessage());
        }
        return usu;
    }
    
    public static boolean agregaranime(listaanime anime){
        try{
            JSONObject js = new JSONObject();
            //nom_anime, gen, cap, id_usu
            js.put("nom_anime", anime.getDes_anime());
            js.put("gen", anime.getId_gen());
            js.put("cap", anime.getCapitulos());
            js.put("id_usu", anime.getId_lista());
            String di = "/lista/Agregar";
            JSONObject jr = peticionPost(di, js);
            String status = jr.getString("status");
            if(status.equals("Guardado")){
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            System.out.println(e.getCause());
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public static boolean cambiarestado(int idanime, int usuario, int estado){
        try{
            JSONObject js = new JSONObject();
            //id_usu, id, estado
            js.put("id_usu", usuario);
            js.put("id", idanime);
            js.put("estado", estado);
            String di = "/lista/Cambiar";
            JSONObject jr = peticionPost(di, js);
            String status = jr.getString("status");
            if(status.equals("Actualizado")){
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            System.out.println(e.getCause());
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public static boolean Eliminar(int idanime, int usuario){
        try{
            JSONObject js = new JSONObject();
            //id_usu, id
            js.put("id_usu", usuario);
            js.put("id", idanime);
            String di = "/lista/Eliminar";
            JSONObject jr = peticionPost(di, js);
            String status = jr.getString("status");
            if(status.equals("Eliminado")){
                return true;
            }else{
                return false;
            }
        }catch(Exception e){
            System.out.println(e.getCause());
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public static List<listaanime> listausuario(int id){
        List<listaanime> lista = new ArrayList<listaanime>();
        try{
            JSONObject js = new JSONObject();
            js.put("id", id);
            String di = "/lista/";
            JSONObject jr = peticionPost(di, js);
            String status = jr.getString("status");
            if(status.equals("encontradas")){
                JSONArray ja = jr.getJSONArray("Datos");
                for(int i=0; i<ja.length(); i++){
                    JSONObject ani = ja.getJSONObject(i);
                    listaanime anime = new listaanime();
                    anime.setId_dlista(ani.getInt("id_dlista"));
                    anime.setCapitulos(ani.getInt("cap"));
                    anime.setDes_anime(ani.getString("des_anime"));
                    anime.setEstado(ani.getInt("estado"));
                    anime.setDes_gen(ani.getString("des_gen"));
                    lista.add(anime);
                }
            }
        }catch(Exception e){
            System.out.println(e.getCause());
            System.out.println(e.getMessage());
        }
        return lista;
    }
}
