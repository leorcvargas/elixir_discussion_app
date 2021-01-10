import { Socket } from "phoenix";

const socket = new Socket("/socket", { params: { token: window.userToken } });
socket.connect();

export const joinTopicChannel = (topicId) => {
  const channel = socket.channel(`comments:${topicId}`, {});
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) });

  return channel;
};

window.joinTopicChannel = joinTopicChannel;
