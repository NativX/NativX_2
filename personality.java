//Connect to watson personality insights and return the profile as json. 
//Connect to the personailty-insights on Bluemix
import com.ibm.watson.developer_cloud.personality_insights.v2;

Class Personailty() {
	PersonalityInsights service = new PersonalityInsights():
	service.setUsernameAndPassword( "599d30f0-89e2-4d59-bd9b-11919b4b9ebc","LJwNxRuuBPlf");

	try {
	  JsonReader jReader = new JsonReader(new FileReader("profile.json"));
	  Content content = GsonSingleton.getGson().fromJson(jReader, Content.class);
	  ProfileOptions options = new ProfileOptions().contentItems(content.getContentItems());
	  Profile profile = service.getProfile(options);
	  System.out.println(profile);
	} catch (FileNotFoundException e) {
	  e.printStackTrace();
	}
}
