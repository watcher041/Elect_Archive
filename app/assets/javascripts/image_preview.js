
// HTMLの読み込みを終了した後に実行
$(function(){
  
  // 画像がファイル選択された場合に起動
  $(".image-file").on("change",function(event){

    // イベントから画像のファイル情報を抜き出す
     var file = event.target.files[0];
    
    // FileReaderオブジェクトを作成します
     var reader = new FileReader();

    // DataURIScheme文字列を取得します
    reader.readAsDataURL(file);
    
    // 読み込みが完了したら処理が実行されます
    reader.onload = function () {

      // ラベルのノードを取得
      $('.file-image').attr("src",this.result)
    
    }

  })

})