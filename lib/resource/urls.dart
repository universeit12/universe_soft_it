class Urls{

  static const String _baseUrl = "https://server3.bifdt.info";


  static const loginUrl = "$_baseUrl/loginApp";
  static const registerUrl = "$_baseUrl/registerApp";
  static const homeVideoUrl = "$_baseUrl/homepageContent";
  static const popularCourseUrl = "$_baseUrl/course";
  static const blogUrl = "$_baseUrl/blog";
  static const freeSeminarUrl = "$_baseUrl/seminarRequest";
  static const addmissionUrl = "$_baseUrl/admission";
  static const facultyUrl = "$_baseUrl/faculty";
  static const studentPhotoGalaryUrl = "$_baseUrl/studentGallery";
  static const notificationUrl = "$_baseUrl/blog";
  static const blogCommentUrl = "$_baseUrl/comments";
  static courseCategoryUrl(String courseID) => "$_baseUrl/courseCategory/course/$courseID";
  static carerObjectiveUrl(String courseID) => "$_baseUrl/objectives/course/$courseID";
  static semesterSpecificCourseUrl(String categoryId) => "$_baseUrl/semesterByCourse/course/$categoryId";
}