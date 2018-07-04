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

### NETWORK CODE
library(tweetscores)
options(stringsAsFactors=F)
oauth_folder = "~/Dropbox/credentials/twitter"

accounts <- getFriends("RECSM_UPF", oauth=oauth_folder)

# creating folders (if they do not exists)
try(dir.create("friends"))

# first check if there's any list of friends already downloaded to 'outfolder'
accounts.done <- gsub(".rdata", "", list.files("friends"))
accounts.left <- accounts[accounts %in% accounts.done == FALSE]
accounts.left <- accounts.left[!is.na(accounts.left)]

# loop over the rest of accounts, downloading friend lists from API
while (length(accounts.left) > 0){
  
  # sample randomly one account to get friends
  new.user <- sample(accounts.left, 1)
  #new.user <- accounts.left[1]
  cat(new.user, "---", length(accounts.left), " accounts left!\n")    
  
  # download followers (with some exception handling...) 
  error <- tryCatch(friends <- getFriends(user_id=new.user,
                                          oauth=oauth_folder, sleep=0.5, verbose=FALSE), error=function(e) e)
  if (inherits(error, 'error')) {
    cat("Error! On to the next one...")
    accounts.left <- accounts.left[-which(accounts.left %in% new.user)]
    next
  }
  
  # save to file and remove from lists of "accounts.left"
  file.name <- paste0("friends/", new.user, ".rdata")
  save(friends, file=file.name)
  accounts.left <- accounts.left[-which(accounts.left %in% new.user)]
  
}

# keeping only those for which we have the name
accounts <- gsub(".rdata", "", list.files("friends"))

# reading and creating network
edges <- list()
for (i in 1:length(accounts)){
  file.name <- paste0("friends/", accounts[i], ".rdata")
  load(file.name)
  if (length(friends)==0){ next }
  chosen <- accounts[accounts %in% friends]
  if (length(chosen)==0){ next }
  edges[[i]] <- data.frame(
    source = accounts[i], target = chosen)
}

edges <- do.call(rbind, edges)
nodes <- data.frame(id_str=unique(c(edges$source, edges$target)))

# adding user data
users <- getUsersBatch(ids=nodes$id_str, oauth=oauth_folder)
nodes <- merge(nodes, users)

library(igraph)
g <- graph_from_data_frame(d=edges, vertices=nodes, directed=TRUE)
g

names(nodes)[1:2] <- c("Id", "Label")
names(edges)[1:2] <- c("Source", "Target")
write.csv(nodes, file="../data/recsm-nodes.csv", row.names=FALSE)
write.csv(edges, file="../data/recsm-edges.csv", row.names=FALSE)

