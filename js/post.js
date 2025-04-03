
function ecrireJobs(){
var yeah=" <select id=\"monjob1\" name=\"job\">";
var maliste=["informatique","ingénieur réseaux et télécoms","expert reseaux","technicien informatique","technicien informatique et réseaux","technicien support informatique","technicien réseau","ingénieur systèmes réseaux et cybersécurité","Technicien(ne) Fibre Optique et Cuivre","INGENIEUR INFORMATIQUE SUPERVISION & RESEAUX","Ingénieur Réseaux Terrain","Ingénieur Logiciel et Systèmes embarqués","INGENIEUR INFORMATIQUE INDUSTRIELLE","Architecte Système","commercial informatique BtoB","ingénieur commercial bureautique informatique","technicien automatisme","technicien methodes gmao","ingénieur électricité cfo cfa","ingénieur développeur python","développeur","technicien de maintenance","techniciens geii","Technicienne de maintenance en informatique","Gestionnaire informatique","responsable informatique","développeur informatique"," Administratrice réseau informatique ","agent d'accueil","technicien burautique","architecte système","administrateur système et réseaux","manager réseau","développeur c++","Programmeur Développement","Programmeur Développement","chargé d'études informatique","responsable des systèmes d'information","ingénieur commercial informatique","ingénieur commercial bureautique","correspondant informatique digital","Spécialiste système d’information","Technicien réseaux et télécommunications","technicien système","technicien courant faible","agent technique","technicien d’agence","Expert Technique Infrastructure","Expert sécurité réseaux","Technicien expert support réseaux et télécoms","Experte back-office","Experte en cybersécurité"," Experte qualité informatique","Experte en application informatique","experte middle-office","Experte méthodes et qualité informatique ","Électricienne réseaux "," Consultante réseaux informatiques ","Planificateur / Planificatrice réseaux de télécoms ","Pupitreur / Pupitreuse réseau informatique"," Responsable des développements informatiques ","ingenieur de donnees","développeur web","électricien réseau","chargée de projet web","référent systèmes informatique"];
var technicien=["Technicien(ne) d'intervention en réseaux électriques ","Aide électricienne monteuse réseaux","ingénieur réseau électrique","technicien en CVC","ELECTRICIEN CABLEUR(H/F)","électricien BT-HT"];
var malisteok=["agronome"];
var malisteokok=["agent de voyage","Agente d'accueil touristique","Agent de voyage d'affaires expérimenté","Agent de voyage billettiste","Organisateur de Voyage","Forfaitiste en agence de voyage"];
var accueil=["agent standardiste","chargé d'accueil","réceptionniste","agent d'information","hôtesse d'accueil standardiste"];
var spectacle=["technicien spectacle site de divertissement"];
var commerce=["vendeuse","assistance commerciale"];
var com=[" Chargée de communication externe "];
var res=["architecte réseaux et sécurité "];
var systeme=[" Auditeur(trice) Sécurité des systèmes d'information (Ssi)","Technicien(ne) systèmes d'information et télécommunications ","Ingénieur Ingénieure intégration de système","Responsable de projet architecture informatique","administrateur systeme informatique","architecte big data","architecte cloud","architecte système d'information","Architecte IoT - Internet des Objets"];
yeah+="  <optgroup label=\"informatique\">"
for (var i=0;i<maliste.length;i++){
yeah+="<option value=\""+maliste[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+maliste[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"agronome\">"
for (var i=0;i<malisteok.length;i++){
yeah+="<option value=\""+malisteok[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+malisteok[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"voyage\">"
for (var i=0;i<malisteokok.length;i++){
yeah+="<option value=\""+malisteokok[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+malisteokok[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"accueil\">"
for (var i=0;i<accueil.length;i++){
yeah+="<option value=\""+accueil[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+accueil[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"spectacle\">"
for (var i=0;i<spectacle.length;i++){
yeah+="<option value=\""+spectacle[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+spectacle[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"vendeuse\">"
for (var i=0;i<commerce.length;i++){
yeah+="<option value=\""+commerce[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+commerce[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"communication\">"
for (var i=0;i<com.length;i++){
yeah+="<option value=\""+com[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+com[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"technicien\">"
for (var i=0;i<technicien.length;i++){
yeah+="<option value=\""+technicien[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+technicien[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"systèmes d'informations\">"
for (var i=0;i<systeme.length;i++){
yeah+="<option value=\""+systeme[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+systeme[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
yeah+="  <optgroup label=\"réseaux\">"
for (var i=0;i<res.length;i++){
yeah+="<option value=\""+res[i].toLowerCase().replace("&","").replace("(","").replace(")","")+"\">"+res[i].toLowerCase()+"</option>";
}
yeah+="  </optgroup>"
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
