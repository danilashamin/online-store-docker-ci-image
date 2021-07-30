FROM openjdk:11

LABEL danilashamin <SHamin_D@utkonos.ru>

ENV ANDROID_COMMAND_LINES_URL https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
ENV GRADLE_URL https://services.gradle.org/distributions/gradle-7.1.1-all.zip
ENV FIREBASE_TOOLS_LATEST https://firebase.tools/bin/linux/latest
ENV LOCAL_HOME /usr/local
ENV ANDROID_SDK_ROOT /usr/local/.android
ENV JQ_URL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
ENV PATH $PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$LOCAL_HOME/firebase:$LOCAL_HOME/.gradle/bin:$LOCAL_HOME/jq:$LOCAL_HOME/apk_upload/bin

RUN cd "$LOCAL_HOME" \
&& mkdir jq && cd jq && curl -o jq $JQ_URL \
&& cd "$LOCAL_HOME" \
&& mkdir .android && cd .android \
&& curl -o sdk.zip $ANDROID_COMMAND_LINES_URL \
&& unzip sdk.zip \
&& rm sdk.zip \
&& mv cmdline-tools tools \
&& mkdir cmdline-tools \
&& mv tools cmdline-tools \
&& yes | sdkmanager "platforms;android-30" \
"build-tools;30.0.3" \
"extras;android;m2repository" \
"extras;google;m2repository" \
&& cd "$LOCAL_HOME" && ls -all && mkdir firebase && cd firebase && curl -Lo firebase_tools "$FIREBASE_TOOLS_LATEST" \
&& cd "$LOCAL_HOME" && curl -L $GRADLE_URL -o gradle-7.1.1-all.zip && unzip gradle-7.1.1-all.zip && rm gradle-7.1.1-all.zip && mv gradle-7.1.1 .gradle

COPY apk_upload /usr/local/apk_upload