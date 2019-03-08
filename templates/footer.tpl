        <div class="footer">
            Dieser Blog wurde mit Smarty entwickelt. | &copy; {$smarty.now|date_format:"%Y"}
        </div>


        <script src="https://cdn.irequire.dev/libs/js/jquery/3.3.1/jquery-3.3.1.min.js"></script>
        <script src="https://cdn.irequire.dev/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.irequire.dev/libs/quill/quill.min.js"></script>
        {assign var='editor' value=$editor|default:false}
        {if $editor}
            {literal}
                <script>
                    var quill = new Quill('#editor', {
                        modules: {
                            toolbar: true
                        },
                        theme: 'snow'
                    });
                    quill.on('text-change', () => {
                        $('#blog_text').val(btoa(unescape(encodeURIComponent($('.ql-editor').html()))));
                    });

                    var form = document.getElementById('createBlog');
                    form.onsubmit = function() {
                        $('#blog_text').val(btoa(unescape(encodeURIComponent($('.ql-editor').html()))));
                        form.submit();
                        return false;
                    };
                </script>
            {/literal}
        {/if}
    </body>
</html>