class Photo{

  final title;
  final url;
  Photo(this.title,this.url);

  factory Photo.fromJson(Map<String,dynamic> data){
return Photo(data['title'], data['url']);

  }
}