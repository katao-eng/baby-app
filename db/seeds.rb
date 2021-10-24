# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Vaccine.first_or_create([
  { id: 1, name: "B型肝炎（１回目）", kind_id: 0 },
  { id: 2, name: "B型肝炎（２回目）", kind_id: 0 },
  { id: 3, name: "B型肝炎（３回目）", kind_id: 0 },
  { id: 4, name: "ロタウイルス（１回目）", kind_id: 2 },
  { id: 5, name: "ロタウイルス（２回目）", kind_id: 2 },
  { id: 6, name: "ロタウイルス（３回目）", kind_id: 2 },
  { id: 7, name: "ヒブ（１回目）", kind_id: 0 },
  { id: 8, name: "ヒブ（２回目）", kind_id: 0 },
  { id: 9, name: "ヒブ（３回目）", kind_id: 0 },
  { id: 10, name: "ヒブ（４回目）", kind_id: 0 },
  { id: 11, name: "小児用肺炎球菌（１回目）", kind_id: 0 },
  { id: 12, name: "小児用肺炎球菌（２回目）", kind_id: 0 },
  { id: 13, name: "小児用肺炎球菌（３回目）", kind_id: 0 },
  { id: 14, name: "小児用肺炎球菌（４回目）", kind_id: 0 },
  { id: 15, name: "四種混合（１回目）", kind_id: 0 },
  { id: 16, name: "四種混合（２回目）", kind_id: 0 },
  { id: 17, name: "四種混合（３回目）", kind_id: 0 },
  { id: 18, name: "四種混合（４回目）", kind_id: 0 },
  { id: 19, name: "BCG（１回目）", kind_id: 1 },
  { id: 20, name: "麻しん・風しん（１回目）", kind_id: 1 },
  { id: 21, name: "麻しん・風しん（２回目）", kind_id: 1 },
  { id: 22, name: "水ぼうそう（１回目）", kind_id: 1 },
  { id: 23, name: "水ぼうそう（２回目）", kind_id: 1 },
  { id: 24, name: "日本脳炎（１回目）", kind_id: 0 },
  { id: 25, name: "日本脳炎（２回目）", kind_id: 0 },
  { id: 26, name: "日本脳炎（３回目）", kind_id: 0 },
  { id: 27, name: "日本脳炎（４回目）", kind_id: 0 },
  { id: 28, name: "HPV（１回目）", kind_id: 0 },
  { id: 29, name: "HPV（２回目）", kind_id: 0 },
  { id: 30, name: "HPV（３回目）", kind_id: 0 }
])