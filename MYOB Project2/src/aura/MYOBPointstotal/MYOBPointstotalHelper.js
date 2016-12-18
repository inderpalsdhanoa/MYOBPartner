({
    removeAppStyles : function() {
        var allLinks = document.getElementsByTagName('link');
        var badLink;
        for (var i = 0; i < allLinks.length; i++) {
            thisLinkUrl=allLinks[i].href;
            var badName='/app.css';
            if (thisLinkUrl.substring( thisLinkUrl.length - badName.length, thisLinkUrl.length ) === badName) badLink = allLinks[i];
        }
        badLink.parentNode.removeChild(badLink);        
    }
})