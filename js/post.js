
function ecrireJobs(){
var yeah=" <select id=\"monjob1\" name=\"job\">";
var maliste=["informatique","technicien informatique","technicien informatique et réseaux","technicien support informatique","technicien réseau","ingénieur systèmes réseaux et cybersécurité","Technicien(ne) Fibre Optique et Cuivre","INGENIEUR INFORMATIQUE SUPERVISION & RESEAUX","Ingénieur Réseaux Terrain","Ingénieur Logiciel et Systèmes embarqués","INGENIEUR INFORMATIQUE INDUSTRIELLE","Architecte Système","commercial informatique BtoB","ingénieur commercial bureautique informatique","technicien automatisme","technicien methodes gmao","ingénieur électricité cfo cfa","ingénieur développeur python","technicien de maintenance","techniciens geii","Technicienne de maintenance en informatique","Gestionnaire informatique","responsable informatique","développeur informatique"," Administratrice réseau informatique ","agent d'accueil","technicien burautique","architecte système","administrateur système et réseaux","manager réseau","développeur c++","Programmeur Développement","Programmeur Développement","chargé d'études informatique","responsable des systèmes d'information","ingénieur commercial informatique","ingénieur commercial bureautique","correspondant informatique digital","Spécialiste système d’information","Technicien réseaux et télécommunications","technicien système"];

for (var i=0;i<maliste.length;i++){
yeah+="<option value=\""+maliste[i].toLowerCase()+"\">"+maliste[i].toLowerCase()+"</option>";
}
yeah+="</select>";
monjob1.outerHTML=yeah;
}
window.onload=function(){
}

$(function(){

$('form:not(#jobform):not(#jobformweb)').on('submit', function () {
  if (window.filesize > 1024*5) {
    alert('max upload size is 5k');
return false;
  }
  $.ajax({
    // Your server script to process the upload
    url: $(this).attr("action"),
    type: 'POST',

    // Form data
    data: new FormData($(this)[0]),

    // Tell jQuery not to process data or worry about content-type
    // You *must* include these options!
    cache: false,
    contentType: false,
    processData: false,

    // Custom XMLHttpRequest
    success: function (data) {
	    console.log("HEY")
	    console.log(JSON.stringify(data))
	    console.log(JSON.stringify(data.redirect))
	    if (data.redirect){
	    window.location=data.redirect;
	    }else{
	    window.location="/welcome";
	    }
},
    xhr: function () {
      var myXhr = $.ajaxSettings.xhr();
      if (myXhr.upload) {
        // For handling the progress of the upload
        myXhr.upload.addEventListener('progress', function (e) {
          if (e.lengthComputable) {
            $('progress').attr({
              value: e.loaded,
              max: e.total,
            });
          }
        }, false);
      }
      return myXhr;
    }
  });
	return false;
  });
  
});
