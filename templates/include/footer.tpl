        <div class="footer">
            {$data.ui.TEXT_UI_FOOTER} | &copy; {$smarty.now|date_format:"%Y"}
        </div>


        <script src="https://cdn.irequire.dev/libs/js/jquery/3.3.1/jquery-3.3.1.min.js"></script>
        <script src="https://unpkg.com/popper.js@1.14.7/dist/umd/popper.min.js"></script>
        <script src="https://cdn.irequire.dev/bootstrap/4.3.1/js/bootstrap.js"></script>
        <script src="https://cdn.irequire.dev/libs/quill/quill.min.js"></script>
        {literal}
            <script>
                $(function () {
                    $('[data-toggle="tooltip"]').tooltip();
                    $('.toast').toast('show');
                })
            </script>
        {/literal}

        {assign var='editor' value=$editor|default:false}
        {if $editor}
            {literal}
                <script>
                    var quill = new Quill('#editor', {
                        modules: {
                            'toolbar': [
                                [{ 'font': [] }, { 'size': [] }],
                                [ 'bold', 'italic', 'underline', 'strike' ],
                                [{ 'color': [] }, { 'background': [] }],
                                [{ 'script': 'super' }, { 'script': 'sub' }],
                                [{ 'header': '1' }, { 'header': '2' }, 'blockquote', 'code-block' ],
                                [{ 'list': 'ordered' }, { 'list': 'bullet'}, { 'indent': '-1' }, { 'indent': '+1' }],
                                [ 'direction', { 'align': [] }],
                                [ 'link', 'video', 'formula' ],
                                [ 'clean' ]
                            ]
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