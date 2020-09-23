document.getElementById("print-btn").addEventListener("click", function() {
     var printContents = document.getElementById("printable_permit").innerHTML;
     var originalContents = document.body.innerHTML;
     document.body.innerHTML = printContents;
     window.print();
     document.body.innerHTML = originalContents;
});