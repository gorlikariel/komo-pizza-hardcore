import React, { ReactElement } from 'react';
import styled from 'styled-components';

interface StyledIconProps {
  onClick?: React.MouseEventHandler;
  width?: string;
  alt: string;
  src: string;
}

function Icon(props: StyledIconProps) {
  return <StyledIcon {...props} />;
}

export default Icon;

const StyledIcon = styled.img<StyledIconProps>`
  width: ${(props) => (props.width ? props.width : '70px')};
  padding: 2px;
`;
