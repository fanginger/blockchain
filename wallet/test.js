function rquest(callback, passData){
    $.ajax({
         type: "POST",
         url: someURL,
         success: function(data) { 
             callback(data, passData)
         }
    });
};  

function myCallback(data, passData) {
    var responseData = data;
    var SomeOtherData = passData
    //do Something
};

rquest(myCallback, "Hello World");