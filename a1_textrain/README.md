Jake Wang

The Code and the relative files are all in the "a1_pde" folder.

#Work in the "C" Range:
1. Video frames are successfully drawn into the screen
2. I decided to load AgencyFB-Bold-48 as my font.
3. The characters starts on the top of the video by text();
4. Characters are able to fall down with some velocity.

#Work in the "B" Range:
1. Characters stop falling once they landed on a dark object
2. I used 128 as the default threshold, and it can be increased by 1 whenever the UP arrow key is pressed and decreased by 1 whenever the DOWN arrow key is pressed.
3. The user can press the SPACEBAR to toggle bewteen the debugging view and the final user view.
4. Video Image is in grayscale and the text rain is in color randomly.
5. I flipped the image by passing all the pixels in inputImage into FlippedImage in reversing order on each row, so the video image looks like be in a mirror.
6. I picked a peom "The Rainy Day" as my theme and all the characters are from this peom by loading "TheRainyDay" text file. Then I took in each sentence and put them into a char array. All the characters would choose from this array.

#Work in the "A" Range:
1. I used a while loop to check if a character is in a black region, if so, the character would lift up by one pixel until it is not in the black region, so that rain cannot pass through any black region
2. Same idea with the while loop above to make sure that the rain would rise up if the viewer raises hand.
3. To display words, I firstly loaded the text file which contains a peom consisting of many words inside of sentences. Then I put all the sentences into a char array. Then I started to randomly pick a postion on the top of the screen for the first character of a word, then I let any characters after the first character follow its position until we see a space, that means it comes to the next word. Then I randomly picked a position for the first character of the next word and so on.  By this way, I recoginzed each word by finding space bewtween words,  randomly choose a place for the first letter and let any other letter of the word follow its position. Moreover, I set up a little time gap bewteen two letters falling so that it still looks like it is at random but can spell out a word.
4. I made an update funtion to give characters velocities according to gravity, which takes a dt, multiply it with the gravity factror that I defined by myself to give me the velocity and then multiply the velocity with the dt to give me the distance that a character should travel during the time period, and its velocity would become faster and faster along with time, which give us more natural look.

Extra Information: For any text file wanted to be loaded and seen words in the file falling, it must have space bewtween words and have space between sentences.
