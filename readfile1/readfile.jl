"""
    data,rows = read_file1(filename,n,keypos,datapos)

ファイル `filename` を `n` 行読み込み、位置 `keypos` 列めをキー、`datapos` 列めを
それに対応する数値として処理する。読み込んだデータをベクトル `data` として、
読み込んだ行数をrowsとして返す。
"""
function read_data(filename::String,n::Int,keypos::Int,datapos::Int)
   # ここで宣言した変数は関数内のどこからでも参照できる
   rows = 0
   data = zeros(Float64,n)

   # ファイルの有無をチェック
   if !isfile(filename)
      error("file not found")
   end

   # ファイルを開く
   open(filename,"r") do ios
      # 末尾まで読む
      while(!eof(ios))
         rows = rows + 1
         # 行を文字列として読み、スペースで分割する
         line = strip(readline(ios))
         gyou = split(line)
         # 列数が範囲内にあることのチェック
         m = length(gyou)
         if m<keypos || m<datapos
            error("Too few number of columns in row:" * string(rows))
         end
         # 文字列を数値に変換
         i = parse(Int,gyou[keypos])
         x = parse(Float64,gyou[datapos])
         # キーが行数を超えている
         if i>n
            error("key out of range")
         end
         # 配列に保存
         data[i] = x
      end
   end
   # データと行数を返す
   return data,rows
end
