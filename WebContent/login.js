
function validate()
{

    var username=document.getElementById("login_username").value;
    var password=document.getElementById("login_password").value;
    var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";

    if(username=="")
    {
        alert("Please enter Username");
        return false;
    }

    if(password=="")
    {
        alert("Please enter Password");
        return false;
    }

    for (var i = 0; i < username.length; i++) {
        if (iChars.indexOf(username.charAt(i)) != -1) {
            alert ("Your username has special characters. \nThese are not allowed.\n Please remove them and try again.");
            return false;
        }
    }

    for (var i = 0; i < password.length; i++) {
        if (iChars.indexOf(password.charAt(i)) != -1) {
            alert ("Your password has special characters. \nThese are not allowed.\n Please remove them and try again.");
            return false;
        }
    }


    return true;

}