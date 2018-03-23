#
# メインの処理を行う関数を定義して実行する。
#
# Julia内で実行する場合
#
#   julia> include("main.jl")
#
# シェル上から実行する場合
# 
#   shell$ julia main.jl
#
# 関数が定義されているファイルを読み込む
include("readfile.jl")

# メイン関数を定義する
function main()
   # 処理を実行する
   # 引数順: 1:ファイル名,2:行数,3:キーの位置,4:値の位置
   # 戻り値: data:読んだデータ, rows:実際に読み込んだ行数
   data,rows = read_data("data.txt",10,1,3)
   println("rows=",rows," mean=",mean(data)," sd=",std(data))

   # 同じデータを辞書で得る
   # 引数順: 1:ファイル名,2:キーの位置,3:値の位置
   # 戻り値: data:読んだデータ
   data = read_data("data.txt",1,3)
   println("rows=",data.count," mean=",mean(values(data))," sd=",std(values(data)))

   # ハッシュをベクトルに変換
   # 方法1: 正攻法
   n = maximum(keys(data))
   datavec1 = zeros(Float64,n)
   for i in keys(data)
      datavec1[i] = data[i]
   end
   # 方法2: 簡潔法
   datavec2 = [ haskey(data,i) ? data[i] : 0.0 for i=1:n ]

   # 同じことの確認
   println(datavec1 == datavec2)

   # 正常に終了
   return true
end

# それを実行する
main()
