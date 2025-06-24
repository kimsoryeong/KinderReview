package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@Controller
public class InstitutionXmlController {

    @GetMapping("/article/institutionXml")
    @ResponseBody
    public String getInstitutionXml() {
        
        StringBuilder resultBuffer = new StringBuilder();

        try {
            String apiUrl = "https://safemap.go.kr/openApiService/data/getInfantFacilityData.do" +
                    "?serviceKey=TYVGBMLA-TYVG-TYVG-TYVG-TYVGBMLAF1" +
                    "&pageNo=1" +
                    "&numOfRows=10" +
                    "&type=json";

            URL url = new URL(apiUrl);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setInstanceFollowRedirects(true);

            int responseCode = con.getResponseCode();

            BufferedReader br = new BufferedReader(new InputStreamReader(
                    responseCode == 200 ? con.getInputStream() : con.getErrorStream(), "UTF-8"));

            String line;
            while ((line = br.readLine()) != null) {
                resultBuffer.append(line);
            }
            br.close();

        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\":\"" + e.getMessage() + "\"}";
        }

        return resultBuffer.toString();
    }

}