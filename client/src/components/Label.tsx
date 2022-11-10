import styled from 'styled-components';

interface LabelProps {
  color?: string;
  text: string;
  fontSize?: string;
  title?: string;
}

const StyledLabel = styled.span<LabelProps>`
  font-size: ${(props) => `${props.fontSize ? props.fontSize : '1.22em'};`}  
  font-weight: 500;
  padding-bottom: 1.5em;
  animation: zoomup 2s linear infinite;
  animation-delay: calc(200ms * var(--i));
  @keyframes zoomup {
    0%,
    100% {
      color: green;
      filter: blur(1px);
      text-shadow: 0 0 10px #00c2ba, 0 0 20px #00c2ba, 0 0 30px #00c2ba,
        0 0 40px #00c2ba, 0 0 60px #00c2ba, 0 0 80px #00c2ba, 0 0 100px #00c2ba,
        0 0 120px #00c2ba;
    }
    5%,
    95% {
      filter: blur(0);
      color: ${(props) => (props.color ? props.color : 'inherit')};
      text-shadow: none;
    }
  }

  @media (max-width: 700px) {
    font-size: 0.8em;
  }
`;

const Label = (props: LabelProps) => {
  console.log(props.title);
  return <StyledLabel {...props}>{props.text}</StyledLabel>;
};

export default Label;
