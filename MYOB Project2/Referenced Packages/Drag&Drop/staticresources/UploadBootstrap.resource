! function(e) {
    "use strict";
    e.FileDialog = function(a) {
        var o = e.extend(e.FileDialog.defaults, a),
            t = e(["<div class='modal' >", "    <div class='modal-dialog'>", "        <div class='modal-content'>", "            <div class='modal-header'>", "           <h4 class='modal-title'>", o.title, "                </h4>", "            </div>", "            <div class='modal-body'>", "                <input type='file' />", "                <div class='bfd-dropfield'>", "                    <div class='bfd-dropfield-inner'>", o.dragMessage, "                    </div>", "                </div>", "                <div class='container-fluid bfd-files'>", "                </div>", "            </div>", "            <div class='modal-footer'>", "                  </div>", "        </div>", "    </div>", "</div>"].join("")),
            n = !1,
            i = e("input:file", t),
            r = e(".bfd-dropfield", t),
            s = e(".bfd-dropfield-inner", r);
        s.css({
            height: o.dropheight,
            "padding-top":"0px"
        }), i.attr({
            accept: o.accept,
            multiple: o.multiple
        }), 
		i.css({
			"display" :"none"
		}),
		r.on("click.bfd", function() {
			
			if(window.FileReader){
					
				}else{
					alert('Drag N Drop is not supported in this browser. Please update your browser.');
					return;
				}
            i.trigger("click")
        });
        var d = [],
            l = [],
            c = function(a) {
				
				
                var n, i, r = new FileReader;
                l.push(r), r.onloadstart = function() {}, r.onerror = function(e) {
                    e.target.error.code !== e.target.error.ABORT_ERR && n.parent().html(["<div class='bg-danger bfd-error-message'>", o.errorMessage, "</div>"].join("\n"))
                }, r.onprogress = function(a) {
					  if (a.lengthComputable) {                                            
							var progress = parseInt( ((a.loaded / a.total) * 100), 10 );
							console.log(progress);
						}
					console.log(a.loaded +'@@@@@@@@@@@@@');
					console.log(a.total +'@@@@@@@@@@@@@');
					console.log(a +'@@@@@@@@@@@@@')
                    var o = Math.round(100 * a.loaded / a.total) + "%";
                    n.attr("aria-valuenow", a.loaded), n.css("width", 100), e(".sr-only", n).text('Uploading..')
                }, r.onload = function(e) {
                    a.content = e.target.result, d.push(a), n.removeClass("active");
					console.log('Started');
					uploadAttachment(a.content.split(';')[1].split(',')[1] , a.name , a.type );
                },
				r.onloadend = function(){
					console.log('loaded');
				};
                var s = e(["<div class='col-xs-7 col-sm-4 bfd-info'>", "    <span class='glyphicon glyphicon-remove bfd-remove'></span>&nbsp;", "    <span class='glyphicon glyphicon-file'></span><marquee scrollamount='3'>&nbsp;" + a.name, "</marquee></div>", "<div class='col-xs-5 col-sm-8 bfd-progress'>", "    <div class='progress'>", "        <div class='progress-bar progress-bar-success progress-bar-striped active' role='progressbar'", "            aria-valuenow='0' aria-valuemin='0' aria-valuemax='" + a.size + "'>", "            <span class='sr-only'>0%</span>", "        </div>", "    </div>", "</div>"].join(""));
                n = e(".progress-bar", s), e(".bfd-remove", s).tooltip({
                    container: "body",
                    html: !0,
                    placement: "top",
                    title: o.removeMessage
                }).on("click.bfd", function() {
                    r.abort();
                    var e = d.indexOf(a);
                    e >= 0 && d.pop(e), i.fadeOut()
                }), i = e("<div style='float:left;width:100px;' class='row'></div>"), i.append(s), e(".bfd-files", t).append(i), r["readAs" + o.readAs](a)
            },
            f = function(e) {
                Array.prototype.forEach.apply(e, [c])
            };
        return i.change(function(e) {
            e = e.originalEvent;
            var a = e.target.files;
            f(a);
            var o = i.clone(!0);
            i.replaceWith(o), i = o
        }), r.on("dragenter.bfd", function() {
            s.addClass("bfd-dragover")
        }).on("dragover.bfd", function(e) {
            e = e.originalEvent, e.stopPropagation(), e.preventDefault(), e.dataTransfer.dropEffect = "copy"
        }).on("dragleave.bfd drop.bfd", function() {
            s.removeClass("bfd-dragover")
        }).on("drop.bfd", function(e) {
            e = e.originalEvent, e.stopPropagation(), e.preventDefault();
            var a = e.dataTransfer.files;
            0 === a.length, f(a)
        }), e(".bfd-ok", t).on("click.bfd", function() {
            var a = e.Event("files.bs.filedialog");
            a.files = d, t.trigger(a), n = !0
        }), t.on("hidden.bs.modal", function() {
            if (l.forEach(function(e) {
                    e.abort()
                }), !n) {
                var a = e.Event("cancel.bs.filedialog");
                t.trigger(a)
            }
            t.remove()
        }), e(document.forms.namedItem('formId')).prepend(t), t
    }, e.FileDialog.defaults = {
        accept: "*",
        cancelButton: "Cancel",
        dragMessage: "Drag and drop files or click here to browse",
        dropheight: 50,
        errorMessage: "An error occured while loading file",
        multiple: !0,
        okButton: "Add To Attachment",
        readAs: "DataURL",
        removeMessage: "Remove&nbsp;file",
        title: "Add Documents"
    }
}(jQuery);