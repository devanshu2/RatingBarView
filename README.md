# RatingBarView
Rating Bar View to Display Rating

let ratingBar = RatingBarView(frame: CGRect(x: 10.0, y: 80.0, width: 73.0, height: 16.0))

ratingBar.cellCornerRadius = 6.5
        
ratingBar.cellImage = #imageLiteral(resourceName: "star")
        
self.view.addSubview(ratingBar)
        
ratingBar.renderView()
