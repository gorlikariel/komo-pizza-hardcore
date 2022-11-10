import styled from 'styled-components';

interface StyledIconProps {
  onClick?: React.MouseEventHandler;
  width?: string;
  alt: string;
  src: string;
}

const StyledIcon = styled.img<StyledIconProps>`
  width: ${(props) => (props.width ? props.width : '4em')};
  padding: 0.5em;
`;

const Icon = (props: StyledIconProps) => {
  return <StyledIcon {...props} />;
};

export default Icon;
