const cloudinary =require('cloudinary');

cloudinary.config({ 
    cloud_name: 'dplt1pfqb', 
    api_key: '216363692571828', 
    api_secret: 'TI1N42Dk0oNfrfBBjNIyN69CoxM' 
  });
  module.exports= async (file)=>{
 try{
    const res =  await cloudinary.uploader.upload(file);
    return res.secure_url;
 }catch(error){
    return error; 

 }
  }
  