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
});