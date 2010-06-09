/**
 * projektunabhängige library mit hilfsfunktionen.
 * projektspezifisches bitte nach project.js !!!
 *
 */

var gecko = (navigator.userAgent.indexOf("Gecko")!=(-1)) ? true : false;
var ie    = document.all ? true : false;

/**
 * browserunabhängig einen event-handler für ein DOM-Element registrieren
 *
 * @param ele referenz auf das element fur das der handler registiert werden soll (ohne anführungszeichen übergeben)
 * @param ev string das event auf das die func aufgerufen werden soll
 * @param func funktion die beim eintreten des events auszuführende funktion (ohne anführungszeichen übergeben)
 * @return
 */
function addEvent(ele, ev, func) {
   if (ele == null) {
      //alert('fehler beim hinzufügen von event-handler:\n event "'+ ev +'", \nfunktion "' + func + '"');
      return false;
   }
   if (document.attachEvent)
   {
      // ie/win
      ele.attachEvent("on"+ev, func);
   }
   else if (document.addEventListener)
   {
      // gecko + w3c
      ele.addEventListener(ev, func, false);
   }
   else
   {
      // one more try - ie5/mac catches this.
      eval("ele.on"+ev+" ="+func);
   }
}

/**
 * browserunabhängig einen event-handler für ein DOM-Element wieder entfernen
 *
 * @param ele referenz auf das element fur das der handler registiert werden soll (ohne anführungszeichen übergeben)
 * @param ev string das event auf das die func aufgerufen werden soll
 * @param func funktion die beim eintreten des events auszuführende funktion (ohne anführungszeichen übergeben)
 * @return
 */
function removeEvent(ele, ev, func) {
   if (document.detachEvent) {
      ele.detachEvent("on"+ev, func);
   } else if (document.removeEventListener) {
      ele.removeEventListener(ev, func, false);
   } else {
      // warning not tested
      eval("ele.on"+ev+" = ''");
   }
}

/**
 * cancel the further bubbling of a captured event
 * to prevent other event handlers from firing
 * @see http://www.quirksmode.org/js/events_order.html -  ppk rocks !
 */
function cancelEventBubble(e)
{
      // ie
   if (window.event) {
      window.event.cancelBubble = true;

   // w3c (gecko)
   } else if (e.stopPropagation) {
      e.stopPropagation();
   } else {
      // we don't known how to cancel it ... better to let it bubble
      // than to throw an error
   }
}

/**
 * fenstergröße browserübergreifend feststellen
 * @return Object {width: w, height:h}
 */
function getWinSize()
{
  var myWidth = 0, myHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    //Non-IE
    myWidth = window.innerWidth;
    myHeight = window.innerHeight;
  } else if( document.documentElement &&
      ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    //IE 6+ in standards compliant mode
    myWidth = document.documentElement.clientWidth;
    myHeight = document.documentElement.clientHeight;
  } else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    //IE 4 compatible
    myWidth = document.body.clientWidth;
    myHeight = document.body.clientHeight;
  }
  size = new Object();
  size.width = myWidth;
  size.height = myHeight;
  return size;
}

function setWinSize(newSize)
{
  //var myWidth = 0, myHeight = 0;
  if( typeof( window.innerWidth ) == 'number' ) {
    //Non-IE
    w = newSize.width || window.outerWidth;
    h = newSize.height || window.outerHeight;
    window.resizeTo(w, h);
  } else {
     alert("window resize not implemented for ie");
  }
}

/**
 * von nodeRef im dom nach oben hangeln bis ich einen
 * node mit namen ancestorNodeName gefunden habe;
 * dann diesen zurückgeben
 */
function getFirstAncestor(nodeRef, ancestorNodeName)
{
   ref = nodeRef;
   if (!ref) return false;
   ancestorNodeName = ancestorNodeName.toUpperCase();
   while(ref.nodeName != ancestorNodeName && ref.nodeName) {
      ref = ref.parentNode;
   }
   return ref;
}

function getNextSibling(nodeRef, siblingNodeName)
{
   ref = nodeRef.nextSibling;
   if (!ref) return false;
   siblingNodeName = siblingNodeName.toUpperCase();
   while(ref.nodeName != siblingNodeName) {
      ref = ref.nextSibling;
   }
   return ref;
}

/**
 * js logging function for firefoxes firebug extension
 * http://www.joehewitt.com/software/firebug/
 */
var debugDiv = false;
function printfire()
{
   if (document.createEvent) {
      // firefox & firebug extension
      printfire.args = arguments;
      var ev = document.createEvent("Events");
      ev.initEvent("printfire", false, true);
      dispatchEvent(ev);
   } else {
     // ie
     if (!debugDiv) {
       debugDiv = document.createElement('DIV');
       debugDiv.style.position = 'absolute';
       debugDiv.style.zIndex = 1000;
       document.body.appendChild(debugDiv);
     }
     debugDiv.innerHTML = debugDiv.innerHTML + arguments[0] + '<br />';
   }
}

/**
 * eine anwendung in einem neuen fenster (möglichst groß, ohne url-leiste, status-leiste und scrollbar) öffnen
 *
 */
function openAppWindow(url, winWidth, winHeight, winName)
{
   var urlToOpen = url;
   var newAppRequiredInnerWidth = 1016;
   var newAppRequiredInnerHeight = 760;
   var newWindowName = winName;

   var margin = 5;
   var border = 5;
   var titlebar = 20;
   var osStatusbar = 30;
   //var newAppRequiredInnerWidth = 1036;
   //var newAppRequiredInnerHeight = 698;

   var newAppRequiredOuterWidth = newAppRequiredInnerWidth + 2*margin + 2*border;
   var newAppRequiredOuterHeight = newAppRequiredInnerHeight + 2*margin + 2*border + titlebar;

   //  fenster in genau der benöigten größe öffnen, keine scrollbars
   var newWinWidth = newAppRequiredInnerWidth;
   var newWinHeight = newAppRequiredInnerHeight;
   var options = "scrollbars=no, resizable=yes, width="+newWinWidth+", height="+newWinHeight+", top="+margin+", left="+margin;

   var newWin = window.open(urlToOpen, newWindowName, options);
   newWin.focus();
}