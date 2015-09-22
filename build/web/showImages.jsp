<%-- 
    Document   : showImages
    Created on : Apr 5, 2015, 4:22:06 PM
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.PhotoBean"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="css/default.css" />
		<link rel="stylesheet" type="text/css" href="css/component.css" />
		<script src="js/modernizr.custom.js"></script>
    </head>
    <body>
        <form id="myform" action="methodservlet"> 
                <input id="input" placeholder="<%=request.getAttribute("keyWords")%>" type="text" name="keyWords" id="search" style="width: 250px; height: 30px; outline: none;"/> 
                <input type="hidden" name="methodName" value="search"/>
                <input id="search_submit"  type="submit" value="Search" style=" height: 30px;"/> 
                <span class="search_ico"></span> 
                </br>
                <select id="language" name="language">
                    <option value="CHINESE_SIMPLIFIED">简体中文</option>
                    <option value="CHINESE_TRADITIONAL">繁體中文</option>
                    <option value="FRENCH">français</option>
                    <option value="DUTCH">Deutsch</option>
                    <option value="RUSSIAN">русский</option>
                    <option value="SPANISH">español</option>
                    <option value="ITALIAN">lingua italiana</option>
                </select>
            </form>   
        <div class="container">	
                    
                                  
			<div class="main">
			</div>
                <button id="og-additems"></button>
		</div><!-- /container -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<script src="js/grid.js"></script>
                <script>
                    		$(document).ready(function() {
			Grid.init();
                        var language = "<%=request.getAttribute("language")%>"
                        $("#language").find('option').each(function(){
                            if($(this).attr('value')==language){
                            $(this).attr("selected","selected");
                            }
                        });
                        
                        var cuPage = 1;
                        var totalPage = <%=(Integer)request.getAttribute("totalPage")%>;
                        $(".main").append('<ul id="og-grid" class="og-grid">');
                        <% List<PhotoBean> photos = (List)request.getAttribute("photos");%>
                                <% for(PhotoBean photo: photos){%>
                                var item = $('<li><a class="oneItem" href="#" photoId="<%=photo.getPhotoID()%>" data-largesrc="<%=photo.getPhotoBigURL()%>" photoURL="<%=photo.getPhotoURL()%>" photoSecret="<%=photo.getPhotoSecret()%>"><img src="<%=photo.getPhotoSmallURL()%>" alt="img01" width="180" height="180"/></a></li>').appendTo("#og-grid"); 
                                Grid.addItems( item );
                                <%}%>
                          
                          if(cuPage >= totalPage){
                        $("#og-additems").css("display","none");    
                        }
                          
                        $("#og-additems").on('click', function(){
                            
                            $(this).css("background","url(/IRProject/images/loading.gif) no-repeat center");
                          
                            $.ajax( {    
                                                url:'methodservlet',// redirect action    
                                                data:{    
                                                         methodName : "more",    
                                                         cuPage : cuPage
                                                },    
                                                type:'post',    
                                                cache:false,    
                                                /*dataType:'json',*/    
                                                success:function(data) {  
                                                    $("#og-additems").css("background","url(/IRProject/images/arrow-down.png) no-repeat center");
                                                    cuPage++;
                                                     if(cuPage >= totalPage){
                                                        $("#og-additems").css("display","none");    
                                                    }
                                                    $(data).find("photo").each(function() {
                                                       
                                                        var item = $('<li><a class="oneItem" href="#" photoId="'+$(this).attr("photoId") +'" data-largesrc="'+$(this).attr("photoBigURL")+'" photoURL="'+$(this).attr("photoURL")+'" photoSecret="'+$(this).attr("photoSecret")+'"><img src="'+$(this).attr("photoSmallURL")+'" alt="img01" width="180" height="180"/></a></li>').appendTo("#og-grid");
                         
                                                        Grid.addItems( item );
                                                    });
                                                                                                           
                                                 },    
                                                 error : function() {    
                                                      // view("Error！");    
                                                      alert("Error!");    
                                                 }    
                                            });  
                                     });
                        });
                        
                        function tagSearch(button){
                            $('#input').attr("value",button.innerHTML);
                            $('#myform').submit();
                        }
                        
                        
                    </script>
    </body>
</html>
