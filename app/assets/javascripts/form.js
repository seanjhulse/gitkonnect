document.addEventListener('DOMContentLoaded', function(event) {
  var toolbarOptions = [
    ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
    ['blockquote', 'code-block'],

    [{ 'header': 1 }, { 'header': 2 }],               // custom button values
    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
    [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript

    [{ 'align': [] }],

    ['clean']                                         // remove formatting button
  ];
  
  var editorEl = document.getElementById('editor');

  if(editorEl) {
    var editor = new Quill('#editor', {
      modules: { 
        toolbar: toolbarOptions
      },
      theme: 'snow'
    });

    var formData = document.getElementById('form-data');

    editor.on('text-change', function() {
      var justHtml = editor.root.innerHTML;
      formData.innerHTML = justHtml;
    });

    editor.root.innerHTML = formData.value;
  }



  // switch toggle
  var switches = document.querySelectorAll('#switcher');
  if(switches.length > 0) {
    for (i = 0; i < switches.length; i++) {
      switches[i].addEventListener('click', function(event) {
        if(event.target.value == "" || event.target.value == 0) {
          event.target.value = 1;
        } else {
          event.target.value = 0;
        }
      });
    }
  }
});