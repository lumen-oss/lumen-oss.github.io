import React from 'react';
import MDXComponents from '@theme-original/MDXComponents';
import { Icon } from '@iconify/react';

function Check() {
  return <Icon icon="mdi:check" style={{color: 'var(--ifm-color-primary)'}} />;
}

function Close() {
  return <Icon icon="mdi:close" style={{color: 'var(--ifm-color-danger)'}} />;
}

export default {
  ...MDXComponents,
  IIcon: Icon,
  Check,
  Close,
};
