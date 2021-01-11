import { Socket } from "phoenix";

const socket = new Socket("/socket", { params: { token: window.userToken } });
socket.connect();

export const getTopicChannel = (topicId) => {
  const channel = socket.channel(`comments:${topicId}`, {});

  return channel;
};

window.getTopicChannel = getTopicChannel;
