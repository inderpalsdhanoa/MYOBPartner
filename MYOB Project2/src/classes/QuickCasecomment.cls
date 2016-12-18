global class QuickCasecomment
{
     
  public QuickCasecomment(ApexPages.StandardController controller)  {  
  }
  
  @RemoteAction
  global static boolean CreateComment(Id CaseId,String comment,string publish){
    CaseComment newCom = new CaseComment();
    newCom.ParentId = CaseId;
    newCom.CommentBody =comment;
    
    if(publish == 'true'){
      newCom.isPublished = true;
    }else{
      newCom.isPublished = false;
    }
    
    try{
      insert newCom;
      return true;
    }
    catch(Exception ex){
      return false;
    }
  }
}