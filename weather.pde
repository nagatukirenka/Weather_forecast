String[] ID = {"011000",
               "014020",
               "016010",
               "017010",
               "020010",
               "030010",
               "040010",
               "050010",
               "060010",
               "070010",
               "080010",
               "090010",
               "100010",
               "110010",
               "120010",
               "130010",
               "140010",
               "150010",
               "160010",
               "170010",
               "180010",
               "190010",
               "200010",
               "210010",
               "220010",
               "230010",
               "240010",
               "250010",
               "260010",
               "270000",
               "280010",
               "290010",
               "300010",
               "310010",
               "320010",
               "330010",
               "340010",
               "350010",
               "360010",
               "370000",
               "380010",
               "390010",
               "400010",
               "410010",
               "420010",
               "430010",
               "440010",
               "450010",
               "460010",
               "471010",
              };
String[] URL = new String[50];
int loop = 0;
int count;
float scroll = 0;
float speed = 100;
void setup(){
  size(100,400);
  for(int i=0;i<ID.length;i++){
    URL[i] = "http://weather.livedoor.com/forecast/webservice/json/v1?city=" + ID[i];
  }
  PFont font = createFont("MS Gothic",20);
  textFont(font);
  textAlign(CENTER,CENTER);
  imageMode(CENTER);
  frameRate(1);
}

void draw(){
  if(count >= 10){
    background(255);
    for(int i=loop;i<4+loop;i++){
      setWeather(i,scroll);
    }
    scroll += speed;
    loop += 1;
    if(loop > 46) loop = 0;
    count = 0;
  }
  count += 1;
}
void setWeather(int i,float scroll){
  scroll = scroll - 4600 * loop;
  String title;
  JSONArray forecasts;
  JSONObject jobj = loadJSONObject(URL[i]);
  title = jobj.getString("title");
  forecasts = jobj.getJSONArray("forecasts");
  String[] city = splitTokens(title);
  
  JSONObject im = forecasts.getJSONObject(1).getJSONObject("image");
  String imURL = im.getString("url");
  PImage img = loadImage(imURL);
  
  JSONObject t = forecasts.getJSONObject(1).getJSONObject("temperature");
  String max = t.getJSONObject("max").getString("celsius");
  String min = t.getJSONObject("min").getString("celsius");
  String tem = max + "/" + min;
  
  fill(0);
  text(city[1],width/2,20+100*(i-loop));
  image(img,width/2,50+100*(i-loop));
  text(tem,width/2,75+100*(i-loop));
  line(0,100+100*(i-loop),width,100+100*(i-loop));
}
