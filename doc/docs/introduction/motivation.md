---
sidebar_position: 1
---

# Motivation

We want state management to be enjoyable! However, we also aim to avoid creating magical tools that start great but eventually become a nightmare for the project. After years of grappling with this issue, we decided to take action.

We looked at successful patterns on the web and noticed the significant growth of `Signals/Atoms`. This inspired us to base our research on reactive micro-states, allowing us to derive multiple micro-states into one seamlessly.

Thus, **ASP** was born. While micro-states brought many benefits, they also introduced the challenge of state segmentation. In large projects, we often ended up with a file full of small **ValueNotifiers** or **Atoms**. Although everything functioned, some updates occurred without the developer's knowledge, leading to uncontrolled side effects.

Moreover, state updates became unpredictable, causing hours of troubleshooting among thousands of micro-states and their computations. ASP v2 aims to bring more predictability and architectural limits necessary for maintainability, creating a multi-modal pattern suitable for both small and large projects.

![ASP](/assets/ASP.png)

