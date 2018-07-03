setwd("~/git/populism")
options(stringsAsFactors=F)

##### TASK 1 #######
# read FB and Twitter data
fb <- readr::read_csv("data-out/facebook-data-MPSA.csv",
                      col_types="ccccdddcccccdd")

fb <- fb[fb$country=="uk",]

write.csv(fb[,c("party", "is_populist", "type", "id_str", "name", "created_at", "text")],
          file="~/git/social-media-upf/data/FB-UK-parties.csv",
          row.names = FALSE)


### contempt classification
setwd("~/Dropbox/research/incivility")
h <- as.data.frame(readr::read_csv("data/f8_results_cleaned_apr13-BACKUP.csv"))
h <- h[h$X_golden=="false",]
h <- h[order(h$attacks_confidence, h$toneconfidence, 
             h$consequences_confidence, h$party_confidence,
             decreasing=TRUE),]
#h <- h[!duplicated(h$comment_id),]

tr <- h[,c('comment_id', 'comment_likes_count', 'comment_message',
          'attacks')]

write.csv(tr, file="~/git/social-media-upf/data/incivility.csv", row.names=FALSE)