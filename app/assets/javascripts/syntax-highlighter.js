document.addEventListener('DOMContentLoaded', function(event) {

  // configures code block styling
  hljs.configure({
    // classPrefix: 'tomorrow '
  });
  
  // highlights all code blocks
  var qlCodes = document.getElementsByTagName('pre');
  for(var i = 0; i < qlCodes.length; i++) {
    // highlights the block
    hljs.highlightBlock(qlCodes[i]);

    // adds the detected language to the code block
    var node = document.createElement('span');
    node.classList.add('detected-language');
    node.innerHTML = qlCodes[i].classList[qlCodes[i].classList.length-1];
    qlCodes[i].append(node)
  }

  
});

